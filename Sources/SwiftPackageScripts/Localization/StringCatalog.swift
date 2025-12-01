//
//  StringCatalog.swift
//  SwiftPackageScripts
//
//  Created by Daniel Saidi on 2025-11-28.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This type can parse Xcode string catalogs that contain
/// manually added keys.
///
/// This type can extract source language, version, and all
/// strings from a file path, JSON string, or JSON encoded
/// data. Since Xcode generated keys are internal, you can
/// run ``generatePublicKeyWrappers(withRootNamespace:)`` to
/// generate a Swift code string with public key wrappers.
///
/// This library has a CLI tool and a Terminal script that
/// will use this class to generate public key wrapper files
/// in the file system.
public struct StringCatalog: Codable {

    /// Parse a string catalog at a certain path.
    public init(path: String) throws {
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        try self.init(data: data)
    }

    /// Parse a string catalog from a JSON string.
    public init(json: String) throws {
        let data = Data(json.utf8)
        try self.init(data: data)
    }

    /// Parse a string catalog from JSON encoded data.
    public init(data: Data) throws {
        let decoder = JSONDecoder()
        let raw = try decoder.decode(RawCatalog.self, from: data)
        strings = Array(raw.strings.keys)
        sourceLanguage = raw.sourceLanguage
        version = raw.version
    }

    /// The string catalog source language.
    public let sourceLanguage: String

    /// The string catalog strings.
    public let strings: [String]

    /// The string catalog version.
    public let version: String
}

extension StringCatalog {

    /// This type represents a codable wrapper.
    struct AnyCodable: Codable {
        init(from decoder: Decoder) throws {
            // We don't care about the value, just consume it
        }
    }

    /// This enum defines all supported parameter types.
    enum ParameterType {
        case string
        case double
        case int

        var swiftType: String {
            switch self {
            case .string: return "String"
            case .double: return "Double"
            case .int: return "Int"
            }
        }
    }

    /// This type represents a raw catalog content.
    struct RawCatalog: Codable {
        let sourceLanguage: String
        let strings: [String: AnyCodable]
        let version: String
    }
}

public extension StringCatalog {

    /// Generate public key wrappers from the string catalog.
    ///
    /// - Parameters:
    ///   - root: The root namespace, by default `l10n`.
    ///   - indentSize: The indentation size, by default `4`.
    func generatePublicKeyWrappers(
        withRootNamespace root: String = "l10n",
        indentSize: Int = 4
    ) -> String {
        let indent = String(repeating: " ", count: indentSize)

        var tree: [String: Any] = [:]

        for key in strings {
            let components = key.split(separator: ".")
            guard components.count >= 1 else { continue }
            let namespace = String(components[0])
            if tree[namespace] == nil {
                tree[namespace] = [String: Any]()
            }
            insertIntoTree(&tree, components: Array(components), fullKey: key)
        }

        var output = "import Foundation\n\n"
        output += "// THIS IS A GENERATED FILE\n"
        output += "// Run the l10n-gen script to regenerate this file.\n"
        output += "public extension LocalizedStringResource {\n\n"
        output += "\(indent)enum \(root) {\n"

        for (namespace, value) in tree.sorted(by: { $0.key < $1.key }) {
            let enumName = namespace.prefix(1).lowercased() + namespace.dropFirst()

            if let subtree = value as? [String: Any] {
                // Namespace with nested content
                output += generateEnum(
                    name: enumName,
                    tree: subtree,
                    prefix: namespace,
                    indent: 2,
                    indentation: indent
                )
            } else if let fullKey = value as? String {
                // Root-level key without namespace
                let parameters = fullKey.parseStringCatalogParameters()
                let cleanKey = fullKey.split(separator: " ")[0]

                let words = splitCamelCase(String(cleanKey))
                let propertyName = toCamelCase(words)
                let xcodeGenerated = propertyName.prefix(1).lowercased() + propertyName.dropFirst()

                if parameters.isEmpty {
                    output += "\(indent)\(indent)public static var \(propertyName): LocalizedStringResource { .\(xcodeGenerated) }\n"
                } else {
                    let params = parameters.map { "_ \($0.name): \($0.type.swiftType)" }.joined(separator: ", ")
                    let args = parameters.map { "\($0.name)" }.joined(separator: ", ")
                    output += "\(indent)\(indent)public static func \(propertyName)(\(params)) -> LocalizedStringResource { .\(xcodeGenerated)(\(args)) }\n"
                }
            }
        }

        output += "\(indent)}\n"
        output += "}"
        return output
    }
}

private extension StringCatalog {
    func insertIntoTree(
        _ tree: inout [String: Any],
        components: [String.SubSequence],
        fullKey: String
    ) {
        guard components.count >= 1 else { return }

        let namespace = String(components[0])

        if components.count == 1 {
            // Single component key - treat as root level
            tree[namespace] = fullKey
            return
        }

        var current = tree[namespace] as! [String: Any]

        // Build the path through the tree
        var path: [String] = []
        for i in 1..<components.count {
            path.append(String(components[i]))
        }

        // Navigate to the correct position and insert
        func insert(into dict: inout [String: Any], path: [String], value: String) {
            guard !path.isEmpty else { return }

            if path.count == 1 {
                // Leaf node - store the full key
                dict[path[0]] = value
            } else {
                // Internal node - create nested dictionary
                let key = path[0]
                if dict[key] == nil {
                    dict[key] = [String: Any]()
                }
                var nested = dict[key] as! [String: Any]
                insert(into: &nested, path: Array(path.dropFirst()), value: value)
                dict[key] = nested
            }
        }

        insert(into: &current, path: path, value: fullKey)
        tree[namespace] = current
    }

    func generateEnum(
        name: String,
        tree: [String: Any],
        prefix: String,
        indent: Int,
        indentation: String
    ) -> String {
        let currentIndent = String(repeating: indentation, count: indent)
        let innerIndent = String(repeating: indentation, count: indent + 1)
        var output = "\(currentIndent)public enum \(name) {\n"

        let sorted = tree.sorted { lhs, rhs in
            // Put nested enums before properties/functions
            let lhsIsDict = lhs.value is [String: Any]
            let rhsIsDict = rhs.value is [String: Any]

            if lhsIsDict != rhsIsDict {
                return lhsIsDict
            }
            return lhs.key < rhs.key
        }

        for (key, value) in sorted {
            if let subtree = value as? [String: Any] {
                // Nested namespace
                let enumName = key.prefix(1).lowercased() + key.dropFirst()
                output += generateEnum(name: enumName, tree: subtree, prefix: "\(prefix).\(key)", indent: indent + 1, indentation: indentation)
            } else if let fullKey = value as? String {
                // Leaf property or function
                let parameters = fullKey.parseStringCatalogParameters()
                let cleanKey = fullKey.split(separator: " ")[0]

                let lastComponent = cleanKey.split(separator: ".").last!
                let words = splitCamelCase(String(lastComponent))
                let propertyName = toCamelCase(words)

                // Generate the Xcode property name by concatenating all components
                let allComponents = cleanKey.split(separator: ".")
                let xcodeGenerated = allComponents.enumerated().map { index, component in
                    let words = splitCamelCase(String(component))
                    let camelCased = toCamelCase(words)
                    return index == 0 ? camelCased : camelCased.prefix(1).uppercased() + camelCased.dropFirst()
                }.joined()

                if parameters.isEmpty {
                    output += "\(innerIndent)public static var \(propertyName): LocalizedStringResource { .\(xcodeGenerated) }\n"
                } else {
                    let params = parameters.map { "_ \($0.name): \($0.type.swiftType)" }.joined(separator: ", ")
                    let args = parameters.map { "\($0.name)" }.joined(separator: ", ")
                    output += "\(innerIndent)public static func \(propertyName)(\(params)) -> LocalizedStringResource { .\(xcodeGenerated)(\(args)) }\n"
                }
            }
        }

        output += "\(currentIndent)}\n"
        return output
    }

    func splitCamelCase(_ string: String) -> [String] {
        var words: [String] = []
        var currentWord = ""

        for char in string {
            if char.isUppercase, !currentWord.isEmpty {
                words.append(currentWord)
                currentWord = String(char)
            } else {
                currentWord.append(char)
            }
        }

        if !currentWord.isEmpty {
            words.append(currentWord)
        }

        return words
    }

    func toCamelCase(_ components: [String]) -> String {
        components.enumerated().map { index, word in
            let lowercased = word.lowercased()
            return index == 0 ? lowercased : lowercased.prefix(1).uppercased() + lowercased.dropFirst()
        }.joined()
    }
}

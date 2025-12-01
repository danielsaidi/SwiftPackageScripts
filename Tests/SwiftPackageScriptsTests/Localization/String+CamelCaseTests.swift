//
//  String+CamelCaseTests.swift
//  SwiftPackageScriptsTests
//
//  Created by Daniel Saidi on 2025-12-01.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import Testing
import Foundation

@testable import SwiftPackageScripts

@Suite("String+CamelCaseTests")
struct String_CamelCaseTests {

    @Suite("Split Camel Case")
    struct SplitCamelCase {

        @Test func emptyString() {
            let result = "".splitCamelCase()
            #expect(result.isEmpty)
        }

        @Test func singleLowercaseWord() {
            let result = "hello".splitCamelCase()
            #expect(result == ["hello"])
        }

        @Test func singleUppercaseWord() {
            let result = "HELLO".splitCamelCase()
            #expect(result == ["H", "E", "L", "L", "O"])
        }

        @Test func singleCapitalizedWord() {
            let result = "Hello".splitCamelCase()
            #expect(result == ["Hello"])
        }

        @Test func simpleCamelCase() {
            let result = "helloWorld".splitCamelCase()
            #expect(result == ["hello", "World"])
        }

        @Test func pascalCase() {
            let result = "HelloWorld".splitCamelCase()
            #expect(result == ["Hello", "World"])
        }

        @Test func multipleCamelCaseWords() {
            let result = "thisIsACamelCaseString".splitCamelCase()
            #expect(result == ["this", "Is", "A", "Camel", "Case", "String"])
        }

        @Test func consecutiveUppercaseLetters() {
            let result = "parseHTMLDocument".splitCamelCase()
            #expect(result == ["parse", "H", "T", "M", "L", "Document"])
        }

        @Test func acronymAtStart() {
            let result = "URLSession".splitCamelCase()
            #expect(result == ["U", "R", "L", "Session"])
        }
        
        @Test func acronymAtEnd() {
            let result = "parseHTML".splitCamelCase()
            #expect(result == ["parse", "H", "T", "M", "L"])
        }

        @Test func singleCharacter() {
            let result = "a".splitCamelCase()
            #expect(result == ["a"])
        }

        @Test func singleUppercaseCharacter() {
            let result = "A".splitCamelCase()
            #expect(result == ["A"])
        }

        @Test func withNumbers() {
            let result = "value123Test".splitCamelCase()
            #expect(result == ["value123", "Test"])
        }

        @Test func withSpecialCharacters() {
            let result = "hello_World".splitCamelCase()
            #expect(result == ["hello_", "World"])
        }

        @Test func realWorldExample() {
            let result = "localizedStringResource".splitCamelCase()
            #expect(result == ["localized", "String", "Resource"])
        }
    }

    @Suite("To Camel Case")
    struct ToCamelCase {

        @Test func emptyCollection() {
            let result = [String]().toCamelCase()
            #expect(result == "")
        }

        @Test func singleLowercaseWord() {
            let result = ["hello"].toCamelCase()
            #expect(result == "hello")
        }

        @Test func singleUppercaseWord() {
            let result = ["HELLO"].toCamelCase()
            #expect(result == "hello")
        }

        @Test func singleMixedCaseWord() {
            let result = ["HeLLo"].toCamelCase()
            #expect(result == "hello")
        }

        @Test func twoWords() {
            let result = ["hello", "world"].toCamelCase()
            #expect(result == "helloWorld")
        }

        @Test func twoUppercaseWords() {
            let result = ["HELLO", "WORLD"].toCamelCase()
            #expect(result == "helloWorld")
        }

        @Test func multipleWords() {
            let result = ["hello", "world", "test"].toCamelCase()
            #expect(result == "helloWorldTest")
        }

        @Test func multipleUppercaseWords() {
            let result = ["HELLO", "WORLD", "TEST"].toCamelCase()
            #expect(result == "helloWorldTest")
        }

        @Test func mixedCase() {
            let result = ["hello", "WORLD", "Test", "CASE"].toCamelCase()
            #expect(result == "helloWorldTestCase")
        }

        @Test func singleLetterWords() {
            let result = ["a", "b", "c"].toCamelCase()
            #expect(result == "aBC")
        }

        @Test func withNumbers() {
            let result = ["value", "123", "test"].toCamelCase()
            #expect(result == "value123Test")
        }

        @Test func withAcronyms() {
            let result = ["parse", "HTML", "document"].toCamelCase()
            #expect(result == "parseHtmlDocument")
        }

        @Test func realWorldExample() {
            let result = ["localized", "String", "Resource"].toCamelCase()
            #expect(result == "localizedStringResource")
        }

        @Test func pascalCaseToLowerCamelCase() {
            let result = ["Hello", "World", "Example"].toCamelCase()
            #expect(result == "helloWorldExample")
        }

        @Test func allCapsWords() {
            let result = ["URL", "SESSION", "MANAGER"].toCamelCase()
            #expect(result == "urlSessionManager")
        }

        @Test func wordsWithSpecialCharacters() {
            let result = ["hello_world", "test-case", "example"].toCamelCase()
            #expect(result == "hello_worldTest-caseExample")
        }

        @Test func manyWords() {
            let result = ["this", "is", "a", "very", "long", "camel", "case", "string"].toCamelCase()
            #expect(result == "thisIsAVeryLongCamelCaseString")
        }
    }
}

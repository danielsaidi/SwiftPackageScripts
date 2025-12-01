//
//  String+StringCatalogTests.swift
//  SwiftPackageScriptsTests
//
//  Created by Daniel Saidi on 2025-12-01.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import Testing
import Foundation

@testable import SwiftPackageScripts

@Suite("StringL10nParamsTests")
struct StringL10nParamsTests {

    @Test func noParameters() {
        let result = "Simple string without parameters".parseStringCatalogParameters()
        #expect(result.isEmpty)
    }

    @Test func singleStringParameter() {
        let result = "Hello %@".parseStringCatalogParameters()
        #expect(result.count == 1)
        #expect(result[0].name == "param1")
        #expect(result[0].type == .string)
    }

    @Test func singleIntParameter() {
        let result = "Count: %lld".parseStringCatalogParameters()
        #expect(result.count == 1)
        #expect(result[0].name == "param1")
        #expect(result[0].type == .int)
    }

    @Test func singleDoubleParameter() {
        let result = "Value: %lf".parseStringCatalogParameters()
        #expect(result.count == 1)
        #expect(result[0].name == "param1")
        #expect(result[0].type == .double)
    }

    @Test func singleFloatParameter() {
        let result = "Value: %f".parseStringCatalogParameters()
        #expect(result.count == 1)
        #expect(result[0].name == "param1")
        #expect(result[0].type == .double)
    }

    @Test func multipleParameters() {
        let result = "User %@ scored %lld points in %lf seconds".parseStringCatalogParameters()
        #expect(result.count == 3)
        #expect(result[0].name == "param1")
        #expect(result[0].type == .string)
        #expect(result[1].name == "param2")
        #expect(result[1].type == .int)
        #expect(result[2].name == "param3")
        #expect(result[2].type == .double)
    }

    @Test func manyParameters() {
        let result = "%@ %lld %f %@ %lld %f %@".parseStringCatalogParameters()
        #expect(result.count == 7)
        #expect(result[0].name == "param1")
        #expect(result[1].name == "param2")
        #expect(result[2].name == "param3")
        #expect(result[3].name == "param4")
        #expect(result[4].name == "param5")
        #expect(result[5].name == "param6")
        #expect(result[6].name == "param7")
    }

    @Test func mixedContentWithParameters() {
        let result = "Welcome to %@! You have %lld new messages.".parseStringCatalogParameters()
        #expect(result.count == 2)
        #expect(result[0].name == "param1")
        #expect(result[0].type == .string)
        #expect(result[1].name == "param2")
        #expect(result[1].type == .int)
    }

    @Test func parameterWithPositionalSpecifiers() {
        let result = "User %1$@ scored %2$lld points".parseStringCatalogParameters()
        #expect(result.count == 2)
        #expect(result[0].name == "param1")
        #expect(result[0].type == .string)
        #expect(result[1].name == "param2")
        #expect(result[1].type == .int)
    }
}

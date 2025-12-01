//
//  StringCatalog+PublicKeysTests.swift
//  SwiftPackageScriptsTests
//
//  Created by Daniel Saidi on 2025-11-28.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftPackageScripts
import Testing

@Suite("StringCatalog+PublicKeysTests")
class StringCatalog_PublicKeysTests {

    let expected = """
  import Foundation
  
  // THIS IS A GENERATED FILE
  // Run the l10n-gen script to regenerate this file.
  public extension LocalizedStringResource {
  
    enum l10n {
      public enum app {
        public enum homeScreen {
          public static var title: LocalizedStringResource { .appHomeScreenTitle }
        }
      }
      public enum general {
        public enum button {
          public static var close: LocalizedStringResource { .generalButtonClose }
        }
        public enum notificationBadge {
          public static func itemsCount(_ param1: Int) -> LocalizedStringResource { .generalNotificationBadgeItemsCount(param1) }
          public static func warning(_ param1: String) -> LocalizedStringResource { .generalNotificationBadgeWarning(param1) }
        }
      }
    }
  }
  """

    @Test func canGeneratePublicKeyWrappersWithCustomIndentSize() async throws {
        let catalog = try StringCatalog(json: stringCatalogJson)
        let wrapperCode = catalog.generatePublicKeyWrappers(indentSize: 2)
        #expect(wrapperCode == expected)
    }

    @Test func canGeneratePublicKeyWrappersWithCustomRootNamespace() async throws {
        let catalog = try StringCatalog(json: stringCatalogJson)
        let wrapperCode = catalog.generatePublicKeyWrappers(withRootNamespace: "sps", indentSize: 2)
        let expected = expected.replacingOccurrences(of: "enum l10n", with: "enum sps")
        #expect(wrapperCode == expected)
    }
}

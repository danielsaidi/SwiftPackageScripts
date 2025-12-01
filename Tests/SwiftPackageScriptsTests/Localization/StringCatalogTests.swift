//
//  StringCatalogTests.swift
//  SwiftPackageScriptsTests
//
//  Created by Daniel Saidi on 2025-11-28.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftPackageScripts
import Testing

@Suite class StringCatalogTests {
    let json = """
  {
    "sourceLanguage" : "en",
    "strings" : {
      "App.HomeScreen.Title" : {
        "extractionState" : "manual",
        "localizations" : {
          "en" : {
            "stringUnit" : {
              "state" : "translated",
              "value" : "Home"
            }
          },
          "sv" : {
            "stringUnit" : {
              "state" : "translated",
              "value" : "Hem"
            }
          }
        }
      },
      "General.Button.Close" : {
        "extractionState" : "manual",
        "localizations" : {
          "en" : {
            "stringUnit" : {
              "state" : "translated",
              "value" : "Close"
            }
          },
          "sv" : {
            "stringUnit" : {
              "state" : "translated",
              "value" : "Stäng"
            }
          }
        }
      },
      "General.NotificationBadge.ItemsCount %lld" : {
        "extractionState" : "manual",
        "localizations" : {
          "en" : {
            "stringUnit" : {
              "state" : "translated",
              "value" : "%1$lld Items"
            }
          }
        }
      },
      "General.NotificationBadge.Warning %@" : {
        "extractionState" : "manual",
        "localizations" : {
          "en" : {
            "stringUnit" : {
              "state" : "translated",
              "value" : "WARNING: %1$@"
            }
          }
        }
      }
    },
    "version" : "1.1"
  }
  """

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

    @Test func canParseJsonString() async throws {
        let catalog = try StringCatalog(json: json)
        #expect(catalog.sourceLanguage == "en")
        #expect(catalog.strings.sorted() == [
            "App.HomeScreen.Title",
            "General.Button.Close",
            "General.NotificationBadge.ItemsCount %lld",
            "General.NotificationBadge.Warning %@"
        ])
        #expect(catalog.version == "1.1")
    }

    @Test func canParseJsonData() async throws {
        let data = Data(json.utf8)
        let catalog = try StringCatalog(data: data)
        #expect(catalog.sourceLanguage == "en")
        #expect(catalog.strings.sorted() == [
            "App.HomeScreen.Title",
            "General.Button.Close",
            "General.NotificationBadge.ItemsCount %lld",
            "General.NotificationBadge.Warning %@"
        ])
        #expect(catalog.version == "1.1")
    }

    @Test func canGeneratePublicKeyWrappersWithCustomIndentSize() async throws {
        let catalog = try StringCatalog(json: json)
        let wrapperCode = catalog.generatePublicKeyWrappers(indentSize: 2)
        #expect(wrapperCode == expected)
    }

    @Test func canGeneratePublicKeyWrappersWithCustomRootNamespace() async throws {
        let catalog = try StringCatalog(json: json)
        let wrapperCode = catalog.generatePublicKeyWrappers(withRootNamespace: "sps", indentSize: 2)
        let expected = expected.replacingOccurrences(of: "enum l10n", with: "enum sps")
        #expect(wrapperCode == expected)
    }
}

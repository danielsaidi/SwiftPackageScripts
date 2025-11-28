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
  // Add your keys to the string catalog and run `make l10n-gen` to update it.
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
          public static func itemsCount(_ value: Int) -> LocalizedStringResource { .generalNotificationBadgeItemsCount(value) }
          public static func warning(_ value: String) -> LocalizedStringResource { .generalNotificationBadgeWarning(value) }
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

  @Test func canGeneratePublicKeyWrappers() async throws {
    let catalog = try StringCatalog(json: json)
    let wrapperCode = catalog.generatePublicKeyWrappers()
    #expect(wrapperCode == expected)
  }
}

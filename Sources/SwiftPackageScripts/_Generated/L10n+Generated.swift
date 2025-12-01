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
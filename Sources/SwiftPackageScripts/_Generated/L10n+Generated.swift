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
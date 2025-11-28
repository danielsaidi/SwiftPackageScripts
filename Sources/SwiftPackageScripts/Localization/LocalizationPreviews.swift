//
//  LocalizationPreviews.swift
//  SwiftPackageScripts
//
//  Created by Daniel Saidi on 2025-11-28.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

#Preview("Internal L10n Keys") {

  NavigationStack {
    VStack {
      // Internal L10n keys
      Button(.generalButtonClose) {
        print("Close")
      }
      .badged(color: .blue)

      Text(.generalNotificationBadgeItemsCount(10))
        .badged(color: .red)

      Text(.generalNotificationBadgeWarning("Danger, danger!"))
        .badged(color: .orange)
    }
    .navigationTitle(.appHomeScreenTitle)
  }
}

extension View {

  func badged(color: Color) -> some View {
    self
      .padding(5)
      .padding(.horizontal, 5)
      .background(color)
      .foregroundStyle(.white)
      .tint(.white)
      .clipShape(.capsule)
  }
}

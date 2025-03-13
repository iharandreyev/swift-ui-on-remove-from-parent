//
//  View+onRemoveFromParent.swift
//  OnRemoveFromParent
//
//  Created by Andreyeu, Ihar on 3/13/25.
//

import SwiftUI

extension View {
  @inline(__always)
  @ViewBuilder
  public func onRemoveFromParent(
    perform onRemoveFromParent: @MainActor @escaping () -> Void
  ) -> some View {
    modifier(
      OnRemoveFromParentModernViewModifier(
        onRemoveFromParent: onRemoveFromParent
      )
    )
  }
}

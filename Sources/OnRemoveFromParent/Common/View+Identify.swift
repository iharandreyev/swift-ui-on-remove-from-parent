//
//  View+Identify.swift
//  OnRemoveFromParent
//
//  Created by Andreyeu, Ihar on 3/8/25.
//

import SwiftUI

extension View {
  /// Binds a view's identity to the given proxy value.
  ///
  /// When the proxy value specified by the `id` parameter changes, the
  /// identity of the view — for example, its state — is reset.
  @inline(__always)
  @ViewBuilder
  public func identify<ID: Hashable & Sendable>(
    as id: ID
  ) -> some View {
    if #available(iOS 17, macCatalyst 17, macOS 14, tvOS 17, visionOS 2, watchOS 11, *) {
      self.id(id)
    } else {
      self.modifier(
        IdentifyViewModifier(id: id)
      )
    }
  }
}

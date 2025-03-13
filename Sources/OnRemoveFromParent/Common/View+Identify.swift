//
//  View+Identify.swift
//  OnRemoveFromParent
//
//  Created by Andreyeu, Ihar on 3/8/25.
//

import SwiftUI

private struct ViewIdentityKey: EnvironmentKey {
  static let defaultValue: ViewIdentity? = nil
}

extension EnvironmentValues {
  var viewIdentity: ViewIdentity? {
    get { self[ViewIdentityKey.self] }
    set { self[ViewIdentityKey.self] = newValue }
  }
}

extension View {
  /// Binds a view's identity to the given proxy value.
  ///
  /// When the proxy value specified by the `id` parameter changes, the
  /// identity of the view — for example, its state — is reset.
  @inline(__always)
  public func identify<ID: Hashable & Sendable>(
    as id: ID
  ) -> some View {
    self
      .environment(\.viewIdentity, ViewIdentity(id))
      .id(id)
  }
}

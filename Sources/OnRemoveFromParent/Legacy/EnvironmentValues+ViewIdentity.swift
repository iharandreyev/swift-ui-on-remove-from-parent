//
//  EnvironmentValues+ViewIdentity.swift
//  OnRemoveFromParent
//
//  Created by Andreyeu, Ihar on 3/13/25.
//

import SwiftUI

private struct ViewIdentityKey: EnvironmentKey {
  static let defaultValue: AnyHashableSendable? = nil
}

extension EnvironmentValues {
  var viewIdentity: AnyHashableSendable? {
    get { self[ViewIdentityKey.self] }
    set { self[ViewIdentityKey.self] = newValue }
  }
}

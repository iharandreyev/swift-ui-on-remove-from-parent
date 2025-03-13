//
//  IdentifyViewModifier.swift
//  OnRemoveFromParent
//
//  Created by Andreyeu, Ihar on 3/13/25.
//

import SwiftUI

@available(iOS, deprecated: 17, message: "")
@available(macCatalyst, deprecated: 17, message: "")
@available(macOS, deprecated: 14, message: "")
@available(tvOS, deprecated: 17, message: "")
@available(visionOS, deprecated: 2, message: "")
@available(watchOS, deprecated: 11, message: "")
struct IdentifyViewModifier: ViewModifier {
  let id: AnyHashableSendable
  
  init<ID: Hashable & Sendable>(id: ID) {
    self.id = AnyHashableSendable(id)
  }
  
  func body(content: Content) -> some View {
    content
      .environment(\.viewIdentity, id)
      .id(id)
  }
}

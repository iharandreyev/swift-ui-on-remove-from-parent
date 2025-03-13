//
//  OnRemoveFromParentModernViewModifier.swift
//  OnRemoveFromParent
//
//  Created by Andreyeu, Ihar on 3/13/25.
//

import SwiftUI

@available(iOS 17, *)
@available(macCatalyst 17, *)
@available(macOS 14, *)
@available(tvOS 17, *)
@available(visionOS 2, *)
@available(watchOS 11, *)
struct OnRemoveFromParentModernViewModifier: ViewModifier {
  @StateObject
  private var reporter: DeinitReporter
  
  init(onRemoveFromParent: @MainActor @escaping () -> Void) {
    _reporter = StateObject(
      wrappedValue: DeinitReporter(onDeinit: onRemoveFromParent)
    )
  }
  
  func body(content: Content) -> some View {
    content
  }
}

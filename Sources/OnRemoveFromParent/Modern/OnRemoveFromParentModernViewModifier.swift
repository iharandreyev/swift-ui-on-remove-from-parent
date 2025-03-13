//
//  OnRemoveFromParentModernViewModifier.swift
//  OnRemoveFromParent
//
//  Created by Andreyeu, Ihar on 3/13/25.
//

import SwiftUI

@available(iOS 17, *)
struct OnRemoveFromParentModernViewModifier: ViewModifier {
  @StateObject
  private var reporter: DeinitReporter
  
  init(onRemoveFromParent: @MainActor @escaping () -> Void) {
    _reporter = StateObject(
      wrappedValue: DeinitReporter(
        onDeinit: {
          Task.detached { @MainActor in
            onRemoveFromParent()
          }
        }
      )
    )
  }
  
  func body(content: Content) -> some View {
    content
  }
}

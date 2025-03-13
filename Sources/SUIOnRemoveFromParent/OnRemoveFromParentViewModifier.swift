//
//  OnRemoveFromParentViewModifier.swift
//  OnRemoveFromParent
//
//  Created by Andreyeu, Ihar on 3/13/25.
//

import SwiftUI

struct OnRemoveFromParentModernViewModifier: ViewModifier {
  private let onRemoveFromParent: @MainActor () -> Void
  
  init(onRemoveFromParent: @MainActor @escaping () -> Void) {
    self.onRemoveFromParent = onRemoveFromParent
  }
  
  func body(content: Content) -> some View {
    ObservedViewContainer(
      onRemoveFromParent: onRemoveFromParent
    ) {
      content
    }
  }
}

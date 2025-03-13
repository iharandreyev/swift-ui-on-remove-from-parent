//
//  ObservedViewContainer.swift
//  OnRemoveFromParent
//
//  Created by Andreyeu, Ihar on 3/13/25.
//

import SwiftUI

struct ObservedViewContainer<Content: View>: View {
  @State
  private var attachment = ViewAttachment()
  
  private let onRemoveFromParent: @MainActor () -> Void
  private let content: () -> Content
  
  init(
    onRemoveFromParent: @MainActor @escaping () -> Void,
    content: @escaping () -> Content
  ) {
    self.onRemoveFromParent = onRemoveFromParent
    self.content = content
  }
  
  var body: some View {
    content()
      .onAppear {
        attachment.onDeinit = nil
      }
      .onDisappear {
        attachment.onDeinit = onRemoveFromParent
      }
  }
}

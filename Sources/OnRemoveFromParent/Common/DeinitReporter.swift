//
//  DeinitReporter.swift
//  OnRemoveFromParent
//
//  Created by Andreyeu, Ihar on 3/8/25.
//

import SwiftUI

@MainActor
final class DeinitReporter: ObservableObject{
  private let onDeinit: @MainActor () -> Void
  
  init(onDeinit: @MainActor @escaping () -> Void) {
    self.onDeinit = onDeinit
  }
  
  deinit {
    Task.detached { @MainActor [onDeinit] in
      onDeinit()
    }
  }
}

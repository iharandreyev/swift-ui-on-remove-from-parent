//
//  DeinitReporter.swift
//  OnRemoveFromParent
//
//  Created by Andreyeu, Ihar on 3/8/25.
//

import SwiftUI

final class DeinitReporter: ObservableObject, Sendable {
  private let onDeinit: @Sendable () -> Void
  
  init(onDeinit: @Sendable @escaping () -> Void) {
    self.onDeinit = onDeinit
  }
  
  deinit {
    onDeinit()
  }
}

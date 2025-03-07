//
//  View+OnRemoveFromParent.swift
//  OnRemoveFromParent
//
//  Created by Andreyeu, Ihar on 3/8/25.
//

import SwiftUI

private struct DeinitReporterKey: EnvironmentKey {
  static let defaultValue: DeinitReporter? = nil
}

private extension EnvironmentValues {
  var deinitReporter: DeinitReporter? {
      get { self[DeinitReporterKey.self] }
      set { self[DeinitReporterKey.self] = newValue }
    }
}

private struct OnRemoveFromParentViewModifier: ViewModifier {
  @Environment(\.viewIdentity)
  private var id
  
  let onRemoveFromParent: @MainActor () -> Void
  
  func body(content: Content) -> some View {
    guard let id else {
      fatalError(
        """
        
        
        Custom view identity is missing!
        
        In order to use 'onRemoveFromParent', a custom identity must be set.
        To fix this issue, provide an identity using 'identify(:)' modifier:

        yourView
          .onRemoveFromParent(perform: { /* task */ }
          .identify(customHashableId)
        """
      )
    }
    
    return content.environment(
      \.deinitReporter,
       DeinitReportersPool.shared.spawn(forKey: id, onDeinit: onRemoveFromParent)
    )
  }
}

extension View {
  /// Attaches a callback that will be invoked when the view is removed from view hierarchy.
  ///
  /// **LIMITATIONS:**
  ///
  /// - The view identity must be bound to a proxy value with `identify(as:)` modifier.
  /// - There can be only a single callback for a given view.
  ///
  ///```swift
  ///enum ViewID: Hashable, Sendable {
  ///  case someView
  ///}
  ///
  ///struct Container: View {
  ///  var body: some View {
  ///    SomeView()
  ///      .onRemoveFromParent {
  ///         /* your work */
  ///      }
  ///      .identify(as: ViewID.someView)
  ///  }
  ///}
  ///```
  ///
  ///
  /// - Parameters:
  ///   - onRemoveFromParent: The closure to be invoked when the view is removed from view hierarchy.
  @inline(__always)
  func onRemoveFromParent(
    perform onRemoveFromParent: @MainActor @escaping () -> Void
  ) -> some View {
    modifier(
      OnRemoveFromParentViewModifier(onRemoveFromParent: onRemoveFromParent)
    )
  }
}

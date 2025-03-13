//
//  OnRemoveFromParentLegacyViewModifier.swift
//  OnRemoveFromParent
//
//  Created by Andreyeu, Ihar on 3/13/25.
//

import IssueReporting
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

//@available(iOS, deprecated: 17, message: "")
struct OnRemoveFromParentLagacyViewModifier: ViewModifier {
  @Environment(\.viewIdentity)
  private var id
  
  let fileID: StaticString
  let line: UInt
  
  let onRemoveFromParent: @MainActor () -> Void
  
  @ViewBuilder
  func body(content: Content) -> some View {
    if let id {
      content.environment(
        \.deinitReporter,
         DeinitReportersPool.shared.spawn(forKey: id, onDeinit: onRemoveFromParent)
      )
    } else {
      content.onAppear {
        reportIssue(
           """
           
           Custom view identity is missing!
           'onRemoveFromParent' closure will never be invoked.
           
           In order to use 'onRemoveFromParent', a custom identity must be set.
           To fix this issue, provide an identity using 'identify(:)' modifier:
           
           yourView
             .onRemoveFromParent(perform: { /* task */ }
             .identify(customHashableId)
           
           Caused by \(fileID):\(line)
           """,
           fileID: fileID,
           line: line
        )
      }
    }
  }
}

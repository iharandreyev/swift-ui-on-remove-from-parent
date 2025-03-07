//
//  DeinitReportersPool.swift
//  OnRemoveFromParent
//
//  Created by Andreyeu, Ihar on 3/8/25.
//

@MainActor
final class DeinitReportersPool {
  private var pool: [AnyHashable: WeakRef<DeinitReporter>] = [:]
  
  static let shared = DeinitReportersPool()
  
  func spawn<Key: Hashable & Sendable>(
    forKey key: Key,
    onDeinit: @MainActor @escaping () -> Void
  ) -> DeinitReporter {
    if let existing = pool[key]?.value {
      return existing
    }
    
    let new = DeinitReporter {
      Task.detached { @MainActor [weak self] in
        onDeinit()
        self?.pool.removeValue(forKey: key)
      }
    }
    
    pool[key] = WeakRef(value: new)
    
    return new
  }
}

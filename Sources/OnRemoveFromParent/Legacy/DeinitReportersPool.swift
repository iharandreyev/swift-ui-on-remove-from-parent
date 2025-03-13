//
//  DeinitReportersPool.swift
//  OnRemoveFromParent
//
//  Created by Andreyeu, Ihar on 3/8/25.
//

@available(iOS, deprecated: 17, message: "")
@available(macCatalyst, deprecated: 17, message: "")
@available(macOS, deprecated: 14, message: "")
@available(tvOS, deprecated: 17, message: "")
@available(visionOS, deprecated: 2, message: "")
@available(watchOS, deprecated: 11, message: "")
@MainActor
final class DeinitReportersPool {
  private var pool: [AnyHashable: WeakRef<DeinitReporter>] = [:]

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

extension DeinitReportersPool {
  static var shared: DeinitReportersPool {
    _shared.value
  }
  
  private static let _shared = LazyValue(DeinitReportersPool())
}

//
//  LazyValue.swift
//  OnRemoveFromParent
//
//  Created by Andreyeu, Ihar on 3/13/25.
//

final class LazyValue<Value> {
  private var valueFactory: (() -> Value)!
  
  private(set) lazy var value: Value = valueFactory() {
    didSet {
      valueFactory = nil
    }
  }
  
  init(_ valueFactory: @autoclosure @escaping () -> Value) {
    self.valueFactory = valueFactory
  }
}

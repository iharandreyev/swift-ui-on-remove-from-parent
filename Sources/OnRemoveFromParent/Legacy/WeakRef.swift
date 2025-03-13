//
//  WeakRef.swift
//  OnRemoveFromParent
//
//  Created by Andreyeu, Ihar on 3/8/25.
//

struct WeakRef<Value: AnyObject> {
  private(set) weak var value: Value?
  
  init(value: Value) {
    self.value = value
  }
}

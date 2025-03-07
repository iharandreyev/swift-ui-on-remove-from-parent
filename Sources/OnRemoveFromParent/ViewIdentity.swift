//
//  ViewIdentity.swift
//  OnRemoveFromParent
//
//  Created by Andreyeu, Ihar on 3/8/25.
//

struct ViewIdentity: Sendable, Hashable {
  let id: Sendable
  
  private let equateTo: @Sendable (ViewIdentity) -> Bool
  private let hashInto: @Sendable (inout Hasher) -> Void
  
  init<ID: Hashable & Sendable>(_ id: ID) {
    self.id = id
    
    equateTo = { rhs in
      guard let rhs = rhs.id as? ID else { return false }
      return rhs == id
    }
    
    hashInto = { hasher in
      hasher.combine(id)
    }
  }
  
  static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.equateTo(rhs)
  }
  
  func hash(into hasher: inout Hasher) {
    hashInto(&hasher)
  }
}

//
//  AnyHashableSendable.swift
//  OnRemoveFromParent
//
//  Created by Andreyeu, Ihar on 3/8/25.
//

struct AnyHashableSendable: Sendable, Hashable, CustomStringConvertible, CustomDebugStringConvertible {
  let description: String
  let debugDescription: String
  
  private let id: Sendable
  private let equateTo: @Sendable (Self) -> Bool
  private let hashInto: @Sendable (inout Hasher) -> Void
  
  init<ID: Hashable & Sendable>(_ id: ID) {
    switch id {
    case let viewIdentity as Self:
      self = viewIdentity
    default:
      self.init(id: id)
    }
  }
  
  private init<ID: Hashable & Sendable>(id: ID) {
    if let description = (id as? CustomStringConvertible)?.description {
      self.description = description
    } else {
      self.description = "\(id)"
    }
    
    if let debugDescription = (id as? CustomDebugStringConvertible)?.debugDescription {
      self.debugDescription = debugDescription
    } else {
      self.debugDescription = "\(id)"
    }
    
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

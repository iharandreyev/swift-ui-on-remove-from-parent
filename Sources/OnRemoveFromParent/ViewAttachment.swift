//
//  ViewAttachment.swift
//  OnRemoveFromParent
//
//  Created by Andreyeu, Ihar on 3/13/25.
//

final class ViewAttachment {
  var onDeinit: (@MainActor () -> Void)?
  
  init() { }
  
  deinit {
    Task.detached { @MainActor [onDeinit] in
      onDeinit?()
    }
  }
}

//
//  Queue.swift
//  CheesTest
//
//  Created by Illya Kuznietsov on 03.03.2021.
//

import Foundation

public struct Queue<T> {
  
  private(set) public var array = [T]()
  
  public var isEmpty: Bool {
    return self.array.isEmpty
  }
  
  public var count: Int {
    return self.array.count
  }
  
  public mutating func enqueue(_ element: T) {
    self.array.append(element)
  }
  
  public mutating func dequeue() -> T? {
    if self.isEmpty {
      return nil
    } else {
      return self.array.removeFirst()
    }
  }
  
  public var front: T? {
    return self.array.first
  }
}

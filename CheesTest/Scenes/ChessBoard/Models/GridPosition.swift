//
//  GridPosition.swift
//  CheesTest
//
//  Created by Illya Kuznietsov on 04.03.2021.
//

import UIKit

public struct GridPosition {
  
  public let x: Int
  public let y: Int
  
  init(x: Int, y: Int) {
    self.x = x
    self.y = y
  }
  
  init(point: CGPoint) {
    x = Int(point.x)
    y = Int(point.y)
  }
}

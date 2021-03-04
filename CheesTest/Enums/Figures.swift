//
//  Figures.swift
//  CheesTest
//
//  Created by Illya Kuznietsov on 03.03.2021.
//

import Foundation

public enum Figures {
  case knight
  case king

  public var moves: [[Int]] {
    switch self {
    case .knight:
      return  [
        [ 2, -1],
        [ 2,  1],
        [-2,  1],
        [-2, -1],
        [ 1,  2],
        [ 1, -2],
        [-1,  2],
        [-1, -2]
      ]
    case .king:
      return [] // we are not interested in kings moves
    }
  }
}


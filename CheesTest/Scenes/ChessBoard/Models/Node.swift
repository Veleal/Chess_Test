//
//  Knight.swift
//  CheesTest
//
//  Created by Illya Kuznietsov on 03.03.2021.
//

public struct Node {
  
  public let position: GridPosition // (x, y) represents chessboard coordinates
  public var path: [GridPosition]
  public var figure: Figures
  
  public init(position: GridPosition, path: [GridPosition] = [], figure: Figures) {
    self.position = position
    self.path = path
    self.figure = figure
  }
}

extension Node: Equatable {
  public static func ==(lhs: Node, rhs: Node) -> Bool {
    return lhs.position.x == rhs.position.x && lhs.position.y == rhs.position.y
  }
}



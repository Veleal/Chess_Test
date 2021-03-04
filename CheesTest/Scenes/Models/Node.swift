//
//  Knight.swift
//  CheesTest
//
//  Created by Illya Kuznietsov on 03.03.2021.
//

public struct Node {
  
  public let position: GridPosition // (x, y) represents chessboard coordinates
  public let path: [GridPosition]
  public var figureMoves: [[Int]]

  public init(position: GridPosition, path: [GridPosition] = [], figureMoves: [[Int]]) {
    self.position = position
    self.path = path
    self.figureMoves = figureMoves
  }
}

extension Node: Equatable {
  public static func ==(lhs: Node, rhs: Node) -> Bool {
    return lhs.position.x == rhs.position.x && lhs.position.y == rhs.position.y
  }
}



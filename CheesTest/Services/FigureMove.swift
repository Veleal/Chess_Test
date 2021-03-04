//
//  FigureMove.swift
//  CheesTest
//
//  Created by Illya Kuznietsov on 03.03.2021.
//

import UIKit

public final class FigureMove: NSObject {

  public static let shared = FigureMove()

  // Find all paths of the figure from source to destination using BFS
  func bfs(src: Node, dest: Node, boardSize: BoardSize, moves: Int = 3)  throws -> [Node] {
    //Create array that will store all valid paths
    var paths = [Node]()
    // Create a queue and enqueue first node
    // Queue node used in BFS
    var q = Queue(array: [Node]())
    q.enqueue(src)

    // Run until queue is empty
    while (!q.isEmpty) {

      // Pop front node and process it
      guard let node = q.dequeue() else { break }

      let x = node.position.x
      let y = node.position.y
      let points = node.path

      // If destination is reached, do not continue this path
      if (node == dest) {
        paths.append(node)
        continue
      }

      // Skip if out of move limit
      if points.count < moves {
        // Check for all possible movements for a figure
        // and enqueue each valid movement
        for i in 0..<node.figureMoves.count {

          // Get the new valid position of figure from current
          // position on chessboard and enqueue it in the queue
          let position = node.figureMoves[i]
          let x1 = x + position[0]
          let y1 = y + position[1]

          if (isValid(x: x1, y: y1, boardSize: boardSize)) {
            let position = GridPosition(x: x1, y: y1)
            var path = points
            path.append(position)

            q.enqueue(Node(position: position, path: path, figureMoves: node.figureMoves))
          }
        }
      }
    }

    if paths.isEmpty { throw BfsError.pathNotFound }

    return paths
  }

  // Check if (x, y) is valid chessboard cordinate
  // Note that a figure cannot go out of the chessboard
  fileprivate func isValid(x: Int, y: Int, boardSize: BoardSize) -> Bool {
    guard (x >= 0 && y >= 0 && x < boardSize.size && y < boardSize.size) else { return false }
    return true
  }
}

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
  func bfs(src: Node, dest: Node, boardSize: BoardSize, maxMoves: Int = 3)  throws -> [Node] {
    //Create array that will store all valid paths
    var paths = [Node]()
    // Create a queue and enqueue first node
    // Queue node used in BFS
    var q = Queue(array: [Node]())
    q.enqueue(src)
    
    // Run until queue is empty
    while (!q.isEmpty) {
      
      // Pop front node and process it
      guard var node = q.dequeue() else { break }
      
      let x = node.position.x
      let y = node.position.y
      let points = node.path
      
      // If destination is reached, do not continue this path
      if (node == dest) {
        node.path.insert(src.position, at: 0)
        paths.append(node)
        continue
      }
      
      // Skip if out of move limit
      let dist = self.getDistanceBetwen(firstPoint: node.position, seconPoint: dest.position)
      let maxReachableDist = ((maxMoves - points.count) * node.figure.distance + 1)
      let isPosibleReach = maxReachableDist > dist
      
      if points.count < maxMoves && isPosibleReach {
        // Check for all possible movements for a figure
        // and enqueue each valid movement
        for i in 0..<node.figure.moves.count {
          
          // Get the new valid position of figure from current
          // position on chessboard and enqueue it in the queue
          let position = node.figure.moves[i]
          let x1 = x + position[0]
          let y1 = y + position[1]
          
          if (isValid(x: x1, y: y1, boardSize: boardSize)) {
            let position = GridPosition(x: x1, y: y1)
            var path = points
            path.append(position)
            q.enqueue(Node(position: position, path: path, figure: node.figure))
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
  
  // checking distance
  private func getDistanceBetwen(firstPoint: GridPosition, seconPoint: GridPosition) -> Int {
    let xDistance = firstPoint.x - seconPoint.x
    let yDistance = firstPoint.y - seconPoint.y
    let distance = xDistance > yDistance ? xDistance : yDistance
    return Int(abs(distance))
  }
}

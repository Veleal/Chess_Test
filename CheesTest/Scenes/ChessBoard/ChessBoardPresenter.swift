//
//  ChessBoardPresenter.swift
//  CheesTest
//
//  Created by Illya Kuznietsov on 03.03.2021.
//

import UIKit

public final class ChessBoardPresenter {
  
  public weak var view: ChessBoardPresenting!
  public var boardSizes: [BoardSizes]!
  
  private var coordinator: ChessBoardCoordination
  private var service: FigureMove
  private var interactor: ChessBoardInteraction
  
  public init(interactor: ChessBoardInteraction, coordinator: ChessBoardCoordination, service: FigureMove = .shared) {
    self.interactor = interactor
    self.coordinator = coordinator
    self.service = service
  }
  
  public func onViewLoaded() {
    boardSizes = interactor.getSizes()
  }
  
  public func calculate(startPosition: GridPosition, destinationPosition: GridPosition, boardSize: BoardSize) {
    let startNode = Node(position: startPosition, figure: Figures.knight) //that can be upgraded by passing figure in func
    let destinationNode = Node(position: destinationPosition, figure: Figures.king)
    
    async(on: .global()) { [unowned self] in
      do {
        let paths = try self.service.bfs(src: startNode, dest: destinationNode, boardSize: boardSize).map{$0.path}
        async() { self.view.display(with: paths) }
      }
      catch BfsError.pathNotFound  {
        async() { self.view.error(with: "No path was found") } //normaly would put string to separate file
      }
      catch let error {
        async() { self.view.error(with: error.localizedDescription) }
      }
    }
  }
}

// MARK: - ChessBoardPresenting

public protocol ChessBoardPresenting: class {
  func display(with paths: [[GridPosition]])
  func error(with text: String)
}

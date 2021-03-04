//
//  ChessBoardInteractor.swift
//  CheesTest
//
//  Created by Illya Kuznietsov on 03.03.2021.
//

import Foundation

public final class ChessBoardInteractor: ChessBoardInteraction {

  public func getSizes() -> [BoardSizes] {
    return BoardSizes.allCases
  }
}

// MARK: - FeedsInteraction

public protocol ChessBoardInteraction {
  func getSizes() -> [BoardSizes]
}

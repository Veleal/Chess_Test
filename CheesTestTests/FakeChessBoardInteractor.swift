//
//  FakeChessBoardInteractor.swift
//  CheesTestTests
//
//  Created by Illya Kuznietsov on 04.03.2021.
//

@testable import CheesTest

public class FakeChessBoardInteractor: ChessBoardInteraction {
  public func getSizes() -> [BoardSizes] {
    return BoardSizes.allCases
  }
}

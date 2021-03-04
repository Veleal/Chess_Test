//
//  ChessBoardPresenterTests.swift
//  CheesTestTests
//
//  Created by Illya Kuznietsov on 04.03.2021.
//

import XCTest

@testable import CheesTest

public class ChessBoardPresenterTests: XCTestCase {

  func testPresenterTellsViewToShowErrorWhenThereOccursErrorCalculation() throws {
    let presenter = ChessBoardPresenter(interactor: FakeChessBoardInteractor(), coordinator: FakeChessBoardCoordinator())
    let view = FakeChessBoardViewController()
    view.presenter = presenter
    presenter.view = view

    presenter.calculate(startPosition: GridPosition(x: 0, y: 0), destinationPosition: GridPosition(x: 10, y: 10), boardSize: BoardSize(size: 11))

    let wait = expectation(description: #function)
    view.errorGotCalled = {
      wait.fulfill()
    }

    waitForExpectations(timeout: 2.0)
  }

  func testPresenterTellsViewToShowResultsWhenThereOccursErrorCalculation() throws {
    let presenter = ChessBoardPresenter(interactor: FakeChessBoardInteractor(), coordinator: FakeChessBoardCoordinator())
    let view = FakeChessBoardViewController()
    view.presenter = presenter
    presenter.view = view

    presenter.calculate(startPosition: GridPosition(x: 0, y: 0), destinationPosition: GridPosition(x: 2, y: 1), boardSize: BoardSize(size: 11))

    let wait = expectation(description: #function)
    view.displayGotCalled = { resultCount in
      XCTAssertEqual(3, resultCount)
      wait.fulfill()
    }

    waitForExpectations(timeout: 2.0)
  }
}


//Also would like to add test to validate grid drawing and figures moves, but out of time.

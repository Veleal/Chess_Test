//
//  FakeChessBoardViewController.swift
//  CheesTestTests
//
//  Created by Illya Kuznietsov on 04.03.2021.
//

import Foundation

@testable import CheesTest

public final class FakeChessBoardViewController: ChessBoardPresenting {

  public var presenter: ChessBoardPresenter!

  public var errorGotCalled: (() -> Void)?
  public var displayGotCalled: ((Int) -> Void)?

  public func display(with paths: [[GridPosition]]) {
    displayGotCalled?(paths.count)
  }

  public func error(with text: String) {
    errorGotCalled?()
  }
}

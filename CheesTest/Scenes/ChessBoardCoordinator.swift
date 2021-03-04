//
//  ChessBoardCoordinator.swift
//  CheesTest
//
//  Created by Illya Kuznietsov on 03.03.2021.
//

import UIKit

public class ChessBoardCoordinator: Coordinator {

  public typealias Controller = ChessBoardViewController

  private weak var navigator: UINavigationController!

  public func start() -> UINavigationController {
    let (navigatee, view) = createViewControllers()
    view.presenter = .init(interactor: ChessBoardInteractor(), coordinator: self)

    defer { self.navigator = navigatee }

    navigatee.setViewControllers([view], animated: false)

    return navigatee
  }
}

extension ChessBoardCoordinator: ChessBoardCoordination {}

// MARK: - FeedCoordination

public protocol ChessBoardCoordination {}

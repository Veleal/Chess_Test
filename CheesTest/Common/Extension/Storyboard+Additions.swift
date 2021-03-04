//
//  Storyboard+Additions.swift
//  CheesTest
//
//  Created by Illya Kuznietsov on 03.03.2021.
//

import UIKit

public extension UIStoryboard {

  private func allocate<T: UIViewController>(with identifier: String) -> T {
    let view = instantiateViewController(withIdentifier: identifier) as! T
    return view
  }

  enum Name: String, CustomStringConvertible {
    case chessBoard

    public var description: String {
      return rawValue.titled
    }

    public func allocate<T: UIViewController>(with identifier: String, using loader: StoryboardLoader = .shared) -> T {
      let storyboard = loader.board(with: self)
      return storyboard.allocate(with: identifier)
    }
  }
}

public final class StoryboardLoader {

  public static let shared = StoryboardLoader()
  private var bundle: Bundle

  public init(bundle: Bundle = .main) {
    self.bundle = bundle
  }

  public func board(with name: UIStoryboard.Name) -> UIStoryboard {
    let storyboard = UIStoryboard(name: name.description, bundle: bundle)

    return storyboard
  }
}

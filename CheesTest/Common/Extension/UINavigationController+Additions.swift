//
//  UINavigationController+Additions.swift
//  CheesTest
//
//  Created by Illya Kuznietsov on 03.03.2021.
//

import UIKit

public extension UINavigationController {

  var rootViewController: UIViewController! {
    return viewControllers.first
  }
}

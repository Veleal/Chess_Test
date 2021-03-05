//
//  ViewController.swift
//  CheesTest
//
//  Created by Illya Kuznietsov on 03.03.2021.
//

import UIKit

public protocol Coordinator: class {
  
  associatedtype Controller: ViewController
  
  func createViewController() -> Controller
  func createNavigationViewController() -> UINavigationController
}

public extension Coordinator where Controller: UIViewController {
  
  func createViewController() -> Controller {
    return Controller.controller()
  }
  
  func createNavigationViewController() -> UINavigationController {
    return Controller.navigation()
  }
  
  func createViewControllers() -> (UINavigationController, Controller) {
    let navigation = Controller.navigation()
    let view = navigation.rootViewController as! Controller
    return (navigation, view)
  }
}

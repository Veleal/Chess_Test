//
//  Dispatch+Additions.swift
//  CheesTest
//
//  Created by Illya Kuznietsov on 04.03.2021.
//

import Foundation

public typealias VoidCallback = () -> Void

public func async(on queue: DispatchQueue = .main, execute: @escaping VoidCallback) {
  queue.async(execute: execute)
}

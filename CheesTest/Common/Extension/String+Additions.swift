//
//  String+Additions.swift
//  CheesTest
//
//  Created by Illya Kuznietsov on 03.03.2021.
//

public extension String {
  
  static let empty = ""
  
  var titled: String {
    return prefix(1).capitalized + dropFirst()
  }
}

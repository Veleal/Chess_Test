//
//  BoardSizes.swift
//  CheesTest
//
//  Created by Illya Kuznietsov on 04.03.2021.
//

import Foundation

public enum BoardSizes: CaseIterable {
    case s_6x6
    case s_7x7
    case s_8x8
    case s_9x9
    case s_10x10
    case s_11x11
    case s_12x12
    case s_13x13
    case s_14x14
    case s_15x15
    case s_16x16
    
    public var size: Int {
        switch self {
        case .s_6x6:
            return  6
        case .s_7x7:
            return  7
        case .s_8x8:
            return  8
        case .s_9x9:
            return  9
        case .s_10x10:
            return  10
        case .s_11x11:
            return  11
        case .s_12x12:
            return  12
        case .s_13x13:
            return  13
        case .s_14x14:
            return  14
        case .s_15x15:
            return  15
        case .s_16x16:
            return  16
        }
    }
    
    public var title: String {
        switch self {
        case .s_6x6:
            return  "6x6"
        case .s_7x7:
            return  "7x7"
        case .s_8x8:
            return  "8x8"
        case .s_9x9:
            return  "9x9"
        case .s_10x10:
            return  "10x10"
        case .s_11x11:
            return  "11x11"
        case .s_12x12:
            return  "12x12"
        case .s_13x13:
            return  "13x13"
        case .s_14x14:
            return  "14x14"
        case .s_15x15:
            return  "15x15"
        case .s_16x16:
            return  "16x16"
        }
    }
}

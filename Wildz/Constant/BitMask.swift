//
//  BitMask.swift
//  Wildz
//
//  Created by Tanya Koldunova on 24.10.2022.
//

import Foundation

enum PhysicsBitMask {
    case castle
    case enemy
    case weapon
    case ball
    case ground
    case coin
    
    var bitMask: UInt32 {
        switch self {
        case .castle:
            return 0x1 << 1
        case .enemy:
            return 0x1 << 2
        case .weapon:
            return 0x1 << 3
        case .ball:
            return 0x1 << 4
        case .ground:
            return 0x1 << 5
        case .coin:
            return 0x1 << 6
        }
    }
}

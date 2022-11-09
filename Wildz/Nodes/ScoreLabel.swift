//
//  ScoreLabel.swift
//  Wildz
//
//  Created by Tanya Koldunova on 06.11.2022.
//

import Foundation
import SpriteKit

class ScoreLabel: SKLabelNode {
    var value: TimeInterval = 0.0 {
        didSet {
            self.setStrokeText(value.timeString(), size: 22)
        }
    }
    convenience init(custom: Bool) {
        self.init("00:00", size: 22)
        self.zPosition = 12
        self.name = "score node"
    }
    
}

extension ScoreLabel: Updatable {
    func update(timeInterval: TimeInterval) {
        value += 0.01
    }
}

//
//  CoinsLabel.swift
//  Wildz
//
//  Created by Tanya Koldunova on 28.10.2022.
//

import Foundation
import SpriteKit

class CoinsLabel: SKSpriteNode {
    
    lazy var coinLabel: SKLabelNode = {
        let label = SKLabelNode("50", size: 22)
        label.zPosition = 21
        return label
    }()
    
    convenience init() {
        self.init(imageNamed: "coinsContainer")
        self.size = CGSize(width: 124, height: 45)
        self.zPosition = 20
        self.name = "coins label"
        coinLabel.position = CGPoint(x: 18, y: -coinLabel.frame.size.height * 0.35)
        self.addChild(coinLabel)
    }
    
    func setText(coins: Int) {
        coinLabel.setStrokeText(coins.description, size: 22)
    }
}

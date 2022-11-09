//
//  ChooseButton.swift
//  Wildz
//
//  Created by Tanya Koldunova on 26.10.2022.
//

import Foundation
import SpriteKit

enum ChooseButtonType: CaseIterable {
    case coinsFactory
    case cannon
    case catapult
    case sandbag
    
    var coinsCount: Int {
        switch self {
        case .coinsFactory:
            return 25
        case .cannon:
            return 50
        case .catapult:
            return 100
        case .sandbag:
            return 50
        }
    }
    
    var previewNode: WeaponProtocol {
        switch self {
        case .coinsFactory:
            let node = CoinsFactoryNode()
            node.physicsBody = nil
            node.zPosition = 21
            node.size = CGSize(width: 19, height: 33)
            return node
        case .cannon:
            let node = CannonNode()
            node.physicsBody = nil
            node.zPosition = 21
            node.size = CGSize(width: 49, height: 32)
            return node
        case .catapult:
            let node = CatapultNode()
            node.physicsBody = nil
            node.zPosition = 21
            node.size = CGSize(width: 39, height: 30)
            return node
        case .sandbag:
            let node = FenceNode()
            node.physicsBody = nil
            node.zPosition = 21
            node.size = CGSize(width: 12, height: 37)
            return node
        }
    }
    
    var node: WeaponProtocol {
        switch self {
        case .coinsFactory:
            return CoinsFactoryNode()
        case .cannon:
            return CannonNode()
        case .catapult:
            return CatapultNode()
        case .sandbag:
            return FenceNode()
        
        }
    }
}

class ChooseButton: SKSpriteNode {
    var type: ChooseButtonType!
    lazy var weaponNode: WeaponProtocol = type.previewNode
    
    lazy var coverNode: SKSpriteNode = {
        let node = SKSpriteNode(color: UIColor(named: "selectColor")!, size: CGSize(width: 70, height: 70))
        node.zPosition = 22
        node.anchorPoint = CGPoint(x: 0.5, y: 0)
        node.name = "cover node"
        return node
    }()
    
    lazy var label: SKLabelNode = {
        let label = SKLabelNode(type.coinsCount.description, size: 12)
        label.zPosition = 21
        return label
    }()
    
    lazy var coinNode: SKSpriteNode = {
       let coinNode = SKSpriteNode(imageNamed: "coins")
        coinNode.size = CGSize(width: 10, height: 10)
        coinNode.zPosition = 21
        return coinNode
    }()
    
    convenience init(type: ChooseButtonType) {
        self.init(imageNamed: "buttonTexture")
        self.type = type
        self.size = CGSize(width: 70, height: 70)
        self.zPosition = 20
        weaponNode.position = CGPoint(x: 0, y: self.size.height/2-weaponNode.size.height/2-12)
        self.addChild(weaponNode)
        let size = label.frame.size.width + coinNode.size.width
        label.position = CGPoint(x: -8, y: -label.frame.size.height - 8)
        coinNode.position = CGPoint(x: 8, y: -label.frame.size.height )
        self.addChild(label)
        self.addChild(coinNode)
    }
    
    func wait() {
        coverNode.size = CGSize(width: 70, height: 70)
        coverNode.position = CGPoint(x: 0, y: -self.size.height/2)
        self.addChild(coverNode)
        coverNode.run(SKAction.sequence([SKAction.resize(toHeight: 0, duration: 10), SKAction.run({
            self.coverNode.removeFromParent()
        })]))
        
    }
}

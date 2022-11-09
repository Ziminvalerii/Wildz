//
//  CastleNode.swift
//  Wildz
//
//  Created by Tanya Koldunova on 24.10.2022.
//

import SpriteKit

class CastleNode: SKSpriteNode {
    
    convenience init() {
        self.init(imageNamed: "castle")
        self.size = CGSize(width: 89, height: 350)
        self.zPosition = 2.0
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.pinned = true
        self.physicsBody?.isDynamic = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicsBitMask.castle.bitMask
        self.physicsBody?.contactTestBitMask = PhysicsBitMask.enemy.bitMask
    }
}

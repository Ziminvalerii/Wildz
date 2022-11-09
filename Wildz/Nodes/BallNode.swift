//
//  BallNode.swift
//  Wildz
//
//  Created by Tanya Koldunova on 25.10.2022.
//

import Foundation
import SpriteKit

enum BallType {
    case cannon
    case catapult
    
    var texture: SKTexture {
        switch self {
        case .cannon:
            return SKTexture(imageNamed: "ball1")
        case .catapult:
            return SKTexture(imageNamed: "ball2")
        }
    }
    
    var size: CGSize {
        switch self {
        case .cannon:
            return CGSize(width: 15, height: 15)
        case .catapult:
            return CGSize(width: 25, height: 25)
        }
    }
    
    var damage: Int {
        switch self {
        case .cannon:
            return 1
        case .catapult:
            return 3
        }
    }
}

class BallNode: SKSpriteNode {
    var damage: Int = 0
    convenience init(type: BallType) {
        self.init(texture: type.texture)
        self.damage = type.damage
        self.size = type.size
        self.zPosition = 7.0
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.collisionBitMask = 1
        self.physicsBody?.categoryBitMask = PhysicsBitMask.ball.bitMask
      //  self.physicsBody?.contactTestBitMask = PhysicsBitMask.enemy.bitMask
    }
    
    func affectedByGravity(_ value: Bool) {
        self.physicsBody?.affectedByGravity = value
    }
    
    func move() {
        guard let scene = self.scene else {return}
        self.run(SKAction.sequence([SKAction.moveTo(x: scene.size.width*0.75, duration: 3.5), SKAction.run({
            self.removeFromParent()
        })]))
    }
    
    func applyImpulse(impulse: CGVector) {
        
        guard let scene = scene else {return}
        self.alpha = 0
        self.run(SKAction.sequence([SKAction.applyImpulse(impulse, duration: 0.1), SKAction.wait(forDuration: 0.1), SKAction.run {
            self.alpha = 1.0
        }, SKAction.wait(forDuration: 1.0), SKAction.run {
               self.physicsBody?.contactTestBitMask = PhysicsBitMask.enemy.bitMask
               self.physicsBody?.collisionBitMask = PhysicsBitMask.ground.bitMask
        }, SKAction.wait(forDuration: 0.05), SKAction.removeFromParent()]))
    }
}

//
//  CannonNode.swift
//  Wildz
//
//  Created by Tanya Koldunova on 25.10.2022.
//

import Foundation
import SpriteKit


class CannonNode: SKSpriteNode, WeaponProtocol {
    var damage: Int = 1
    var strength: Int = 10
    convenience init() {
        self.init(texture: UserDefaultsValues.currentCannon.texture)
        self.size = CGSize(width: 75, height: 43)
        self.zPosition = 6
         setUpPhysics()
    }
    
    func hitAction() {
        self.run(SKAction.repeatForever(SKAction.sequence([SKAction.run(createBall), SKAction.wait(forDuration: 2.5)])))
    }
    
    func createBall() {
        guard let scene = scene else {return}
        fallSoundPlay()
        let ball = BallNode(type: .cannon)
        ball.physicsBody?.contactTestBitMask = PhysicsBitMask.enemy.bitMask
        ball.affectedByGravity(false)
        ball.position = CGPoint(x: self.position.x + self.size.width/2 + ball.size.width/2 + 8, y: self.frame.maxY - ball.size.height/2)
        self.addChild(ball)
        ball.move()
    }
    
//    func setUpPhysics() {
//        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
//        self.physicsBody?.isDynamic = true
//        self.physicsBody?.pinned = true
//        self.physicsBody?.allowsRotation = false
//        self.physicsBody?.categoryBitMask = PhysicsBitMask.weapon.bitMask
//        self.physicsBody?.contactTestBitMask = PhysicsBitMask.enemy.bitMask
//    }
}

//
//  EnemyProtocol.swift
//  Wildz
//
//  Created by Tanya Koldunova on 01.11.2022.
//

import Foundation
import SpriteKit

protocol EnemyProtocol: SKSpriteNode {
    var hp: Int {get set}
    var type: RewardType {get set}
    var walkTextures: [SKTexture] {get set}
    var deadTextures: [SKTexture] {get set}
    var eatTextures: [SKTexture] {get set}
    func setUpPhysics()
    func move()
    func animateWalk()
    func animateDead()
    func animateEat()
    func eatObstacle(weaponNode: WeaponProtocol)
    func setRewardAction()
}

extension EnemyProtocol {
    func setUpPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsBitMask.enemy.bitMask
        self.physicsBody?.contactTestBitMask = PhysicsBitMask.castle.bitMask
        self.physicsBody?.collisionBitMask = PhysicsBitMask.weapon.bitMask
    }
    
    func animateWalk() {
        self.run(SKAction.repeatForever(
        SKAction.animate(with: walkTextures,
                         timePerFrame: 0.1,
                         resize: false,
                         restore: true)),
        withKey:"walking")
    }
    
    func animateDead() {
        self.run(SKAction.sequence([SKAction.animate(with: deadTextures, timePerFrame: 0.1), SKAction.removeFromParent()]))
    }
    
    func animateEat() {
        self.run(SKAction.repeatForever(SKAction.sequence([ SKAction.animate(with: eatTextures,
                                                                             timePerFrame: 0.1,
                                                                             resize: false,
                                                                             restore: true), SKAction.wait(forDuration: 0.5)])),
        withKey:"eating")
    }
    
    func move() {
        animateWalk()
        guard let scene = self.scene else {return}
        self.run(SKAction.sequence([SKAction.moveTo(x: -scene.size.width/2, duration: 55), SKAction.run({
            self.removeFromParent()
        })]), withKey: "enemy run action")
    }
    
    func eatObstacle(weaponNode: WeaponProtocol) {
        self.removeAction(forKey: "walking")
        animateEat()
        if let runAction = self.action(forKey: "enemy run action") {
            if runAction.speed > 0 {
                runAction.speed = 0
            }
            let action = SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.run {
                weaponNode.strength -= 1
                if weaponNode.strength < 0 {
                    runAction.speed = 1
                    weaponNode.removeFromParent()
                    self.animateWalk()
                    self.removeAction(forKey: "eating")
                    if let action = self.action(forKey: "eat obstacle action") {
                        self.removeAction(forKey: "eat obstacle action")
                    }
                }
            }])
            self.run(SKAction.repeatForever(action), withKey: "eat obstacle action")
           
        }
    }
    
    func setRewardAction() {
        type.createReward(node: self)
    }
}

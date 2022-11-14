//
//  EnemyNode.swift
//  Wildz
//
//  Created by Tanya Koldunova on 25.10.2022.
//

import Foundation
import SpriteKit

enum RewardType: CaseIterable {
    case coins
    case lightning
    case none
    
//    var node: SKSpriteNode {
//        switch self {
//        case .coins:
//            return CoinNode()
//        case .lightning:
//            <#code#>
//        case .none:
//            <#code#>
//        }
//    }
    
    func createReward(node: EnemyProtocol) {
        switch self {
        case .coins:
            guard let scene = node.scene as? GameScene else {return}
            let coin = CoinNode()
            node.move(toParent: scene)
            scene.gameManager.toucheble.append(coin)
            coin.position = node.position
            scene.addChild(coin)
            coin.move(pos: node.position)
        case .lightning:
            guard let scene = node.scene as? GameScene else {return}
            let lightningNode = LightningNode()
            node.move(toParent: scene)
            scene.gameManager.toucheble.append(lightningNode)
            lightningNode.position = node.position
            scene.addChild(lightningNode)
            lightningNode.move(pos: node.position)
        case .none:
            return
        }
    }
}


class EnemyNode: SKSpriteNode, EnemyProtocol {
    var hp = 10
    var type: RewardType = .none
    
    var walkTextures: [SKTexture] = [SKTexture(imageNamed: "zombieTexture1"), SKTexture(imageNamed: "zombieTexture2"), SKTexture(imageNamed: "zombieTexture3"), SKTexture(imageNamed: "zombieTexture4"), SKTexture(imageNamed: "zombieTexture5"), SKTexture(imageNamed: "zombieTexture6"), SKTexture(imageNamed: "zombieTexture7"), SKTexture(imageNamed: "zombieTexture8"), SKTexture(imageNamed: "zombieTexture9"), SKTexture(imageNamed: "zombieTexture10"), SKTexture(imageNamed: "zombieTexture11"), SKTexture(imageNamed: "zombieTexture12"), SKTexture(imageNamed: "zombieTexture13"), SKTexture(imageNamed: "zombieTexture14")]
    
    var deadTextures: [SKTexture] = [SKTexture(imageNamed: "deadZombieTexture1"), SKTexture(imageNamed: "deadZombieTexture2"), SKTexture(imageNamed: "deadZombieTexture3"), SKTexture(imageNamed: "deadZombieTexture4"), SKTexture(imageNamed: "deadZombieTexture5")]
    
    var eatTextures: [SKTexture] = [SKTexture(imageNamed: "eatZombieTexture1"), SKTexture(imageNamed: "eatZombieTexture2"), SKTexture(imageNamed: "eatZombieTexture3"), SKTexture(imageNamed: "eatZombieTexture4"), SKTexture(imageNamed: "eatZombieTexture5"), SKTexture(imageNamed: "eatZombieTexture6"), SKTexture(imageNamed: "eatZombieTexture7")]
    
    private var types = RewardType.allCases
    convenience init() {
        self.init(imageNamed: "zombieTexture1")
        self.size = CGSize(width: 60, height: 80)
        self.zPosition = 5
        self.name = "enemy node"
        setUpPhysics()
        self.type = types[Int.random(in: 0..<types.count)]
        print("enemy type \(type)")
    }
    
//    func setUpPhysics() {
//        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
//        self.physicsBody?.affectedByGravity = false
//        self.physicsBody?.categoryBitMask = PhysicsBitMask.enemy.bitMask
//        self.physicsBody?.contactTestBitMask = PhysicsBitMask.castle.bitMask //| PhysicsBitMask.ball.bitMask
//        self.physicsBody?.collisionBitMask = PhysicsBitMask.castle.bitMask | PhysicsBitMask.weapon.bitMask
//    }
//    
//    func move() {
//        animateWalk()
//        guard let scene = self.scene else {return}
//        self.run(SKAction.sequence([SKAction.moveTo(x: -scene.size.width/2, duration: 55), SKAction.run({
//            self.removeFromParent()
//        })]), withKey: "enemy run action")
//    }
//
//    func animateWalk() {
//        self.run(SKAction.repeatForever(
//        SKAction.animate(with: walkTextures,
//                         timePerFrame: 0.1,
//                         resize: false,
//                         restore: true)),
//        withKey:"walking")
//    }
//
//    func animateDead() {
//        self.run(SKAction.sequence([SKAction.animate(with: deadTextures, timePerFrame: 0.1), SKAction.removeFromParent()]))
//    }
//
//    func eatObstacle(weaponNode: WeaponProtocol) {
//        self.removeAction(forKey: "walking")
//        if let runAction = self.action(forKey: "enemy run action") {
//            if runAction.speed > 0 {
//                runAction.speed = 0
//            }
//            let action = SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.run {
//                weaponNode.strength -= 1
//                if weaponNode.strength < 0 {
//                    runAction.speed = 1
//                    weaponNode.removeFromParent()
//                    self.animateWalk()
//                    if let action = self.action(forKey: "eat obstacle action") {
//                        self.removeAction(forKey: "eat obstacle action")
//                    }
//                }
//            }])
//            self.run(SKAction.repeatForever(action), withKey: "eat obstacle action")
//
//        }
//    }
//
//    func setRewardAction() {
//        type.createReward(node: self)
//    }
}

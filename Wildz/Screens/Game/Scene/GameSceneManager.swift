//
//  GameSceneManager.swift
//  Wildz
//
//  Created by Tanya Koldunova on 24.10.2022.
//

import SpriteKit

class GameSceneManager: NSObject, GameSceneManagerProtocol {
    weak var scene: SKScene?
    weak var contactManager: ContactManager?
    var parentViewController: UIViewController!
    var coinsCount: Int = 0 {
        didSet {
            if let coinsLabel = scene?.childNode(withName: "coins label") as? CoinsLabel {
                coinsLabel.setText(coins: coinsCount)
            }
        }
    }
    var gameTime: TimeInterval?
    var toucheble: [Touchable] = [Touchable]()
    var updatable: [Updatable] = [Updatable]()
    var endless: [Endless] = [Endless]()
    var groundNodes: [GroundNode] = [GroundNode]()
   
    required init?(scene : GameScene) {
        self.scene = scene
        self.scene?.backgroundColor = .white
        super.init()
        coinsCount = 50
        preparePhysicsForWold(for: scene)
    }
    
    func preparePhysicsForWold(for scene: SKScene) {
        scene.physicsWorld.gravity = CGVector(dx: 0, dy: -7)
        scene.physicsWorld.contactDelegate = self
    }
}

extension GameSceneManager: Dependable {
    func receiveMessage<T>(with arguments: T) {
    }
}

extension GameSceneManager : SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == PhysicsBitMask.enemy.bitMask | PhysicsBitMask.ball.bitMask {
            var enemyNode: SKNode?
            var ballNode: SKNode?
            if  contact.bodyA.categoryBitMask == PhysicsBitMask.enemy.bitMask {
                enemyNode = contact.bodyA.node
                ballNode = contact.bodyB.node
            } else {
                ballNode = contact.bodyA.node
                enemyNode = contact.bodyB.node
            }
            if let enemyNode = enemyNode as? EnemyProtocol, let ball = ballNode as? BallNode {
                enemyNode.hp -= ball.damage
                ball.removeFromParent()
                if enemyNode.hp < 0 {
                    playPopVibration()
                    enemyNode.setRewardAction()
                    enemyNode.animateDead()
                }
            }
        } else if collision == PhysicsBitMask.weapon.bitMask | PhysicsBitMask.enemy.bitMask {
            var enemyNode: SKNode?
            var weaponNode: SKNode?
            if  contact.bodyA.categoryBitMask == PhysicsBitMask.enemy.bitMask {
                enemyNode = contact.bodyA.node
                weaponNode = contact.bodyB.node
            } else {
                weaponNode = contact.bodyA.node
                enemyNode = contact.bodyB.node
            }
            if let enemyNode = enemyNode as? EnemyProtocol, let weaponNode = weaponNode as? WeaponProtocol {
                enemyNode.eatObstacle(weaponNode: weaponNode)
               
            }
        } else if collision == PhysicsBitMask.castle.bitMask | PhysicsBitMask.enemy.bitMask {
            if let scene = scene as? GameScene {
                scene.switchState(state: .gameOver)
            }
        }
    }
}


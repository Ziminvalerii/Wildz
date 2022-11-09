//
//  StartScene.swift
//  Wildz
//
//  Created by Tanya Koldunova on 26.10.2022.
//

import UIKit
import SpriteKit

class StartScene: SKScene {
    lazy var backgroundNode: SKSpriteNode = createBackground()
    private var zombiePositions: [(CGPoint, CGPoint, CGFloat)] = [
        (CGPoint(x: -UIScreen.main.bounds.width/2 - 30, y:  -UIScreen.main.bounds.height/2 + 40), CGPoint(x:  -UIScreen.main.bounds.width/2 + 45, y: -UIScreen.main.bounds.height/2 + 40), -120),
        (CGPoint(x: UIScreen.main.bounds.width/2 + 30, y:  UIScreen.main.bounds.height/2 - 30), CGPoint(x:  UIScreen.main.bounds.width/2 - 45, y: UIScreen.main.bounds.height/2 - 40), 40),
        (CGPoint(x: -UIScreen.main.bounds.width/2 - 30, y:  UIScreen.main.bounds.height/2 - 40), CGPoint(x:  -UIScreen.main.bounds.width/2 + 45, y: UIScreen.main.bounds.height/2 - 40), -40),
        (CGPoint(x: UIScreen.main.bounds.width/2 + 30, y:  -UIScreen.main.bounds.height/2 + 40), CGPoint(x:  UIScreen.main.bounds.width/2 - 45, y: -UIScreen.main.bounds.height/2 + 40), 120),
    ]
    var prev: Int?
    
    override func sceneDidLoad() {
        self.size = UIScreen.main.bounds.size
    }
    override func didMove(to view: SKView) {
        self.addChild(backgroundNode)
        self.run(SKAction.repeatForever(SKAction.sequence([SKAction.run(createEnemies), SKAction.wait(forDuration: 4.0)])))
    }
    
    func createBackground() -> SKSpriteNode {
        let backgroundNode = SKSpriteNode(imageNamed: "startBackground")
        backgroundNode.size = self.size
        backgroundNode.zPosition = 1.0
        return backgroundNode
    }
    
    func createEnemies() {
        let zombie = EnemyNode()
        zombie.size = CGSize(width: 120, height: 160)
        let zombieData = zombiePositions[Int.random(in: 0..<zombiePositions.count)]
        zombie.position = zombieData.0
        zombie.zRotation = zombieData.2
        self.addChild(zombie)
        zombie.run(SKAction.sequence([SKAction.move(to: zombieData.1, duration: 2), SKAction.move(to: zombieData.0, duration: 2), SKAction.removeFromParent()]))
    }
    
    
}

//
//  CoinNode.swift
//  Wildz
//
//  Created by Tanya Koldunova on 27.10.2022.
//

import SpriteKit

class CoinNode: SKSpriteNode {
    convenience init() {
        self.init(imageNamed: "coins")
        self.size = CGSize(width: 20, height: 20)
        self.zPosition = 7.0
    }
    
    func move(pos: CGPoint? = nil) {
        var position = CGPoint.zero
        var actions: [SKAction] = [SKAction]()
        if let parent = parent as? SKSpriteNode {
        var position = CGPoint(x: 0, y: parent.size.width/2 + self.size.width)
            actions.append(SKAction.move(to: position, duration: 1.5))
        }
        if let pos = pos {
            position = pos
        }
        let action = SKAction.repeatForever(SKAction.sequence([SKAction.moveTo(y: position.y + 4, duration: 0.5), SKAction.moveTo(y: position.y - 4, duration: 0.5)]))
        actions.append(action)
        self.run(SKAction.sequence(actions))
    }
}

extension CoinNode: ButtonType {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let scene = scene else {return}
        if containsTouches(touches: touches, scene: scene, node: self) {
            collectSoundPlay()
            self.removeFromParent()
            if let scene = scene as? GameScene {
                scene.gameManager.coinsCount += 25
            }
        }
    }
}

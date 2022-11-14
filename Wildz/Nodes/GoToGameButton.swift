//
//  GoToGameButton.swift
//  Wildz
//
//  Created by Tanya Koldunova on 06.11.2022.
//

import SpriteKit

class GoToGameButtonNode: SKSpriteNode {
    var delegate: Dependable {
        guard let delegate = scene as? Dependable else {
            fatalError("ButtonNode may only be used within a `ButtonNodeResponderType` scene.")
        }
        return delegate
    }
    
    var label: SKLabelNode = {
        let node = SKLabelNode("Get it", size: 24)
        node.zPosition = 32
        node.name = "game over label"
        return node
    }()
    
    convenience init() {
        self.init(imageNamed: "mainButtonTexture")
        self.size = CGSize(width: 274, height: 70)
        self.zPosition = 31.0
        label.position = CGPoint(x: 0, y: -label.frame.height/2)
        self.addChild(label)
        self.name = "gameOverButton"
    }
}

extension GoToGameButtonNode: ButtonType {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let scene = scene else {return}
        if containsTouches(touches: touches, scene: scene, nodeNames: ["gameOverButton", "game over label"]) {
            delegate.switchState(state: .goToGame)
        }
    }
}

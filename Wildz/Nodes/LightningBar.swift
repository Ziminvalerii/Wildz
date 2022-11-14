//
//  ProgressBar.swift
//  Wildz
//
//  Created by Tanya Koldunova on 28.10.2022.
//

import Foundation

import SpriteKit


class LightningBar: SKSpriteNode {
    var lightningCount = CGFloat(0) {
        didSet {
            setText()
        }
    }
     var maxLightning = CGFloat(8)
    var width: CGFloat = 0
    
//    private lazy var progressBar:SKSpriteNode = {
//     //   let node = SKSpriteNode(color: .red, size: CGSize(width: width, height: progressBarContainer.size.height))
//        let node = SKSpriteNode(imageNamed: "lightningIndicator")
//        node.size = CGSize(width: width, height: 25)
//        node.zPosition = 23
//        return node
//    }()
    
    private lazy var lightningCountLabel: SKLabelNode = {
        let label = SKLabelNode("\(Int(lightningCount).description)\\\(Int(maxLightning).description) ", size: 22)
        label.zPosition = 24
        return label
    }()
    convenience init() {
        self.init(imageNamed: "lightningBarTexture")
        self.size = CGSize(width: 124, height: 45)
        self.zPosition = 22
        self.name = "lightning bar node"
       // progressBar.position = CGPoint(x: -self.size.width/2 + progressBar.size.width/2, y: 0)
        lightningCountLabel.position = CGPoint(x: lightningCountLabel.frame.width/2 - 2, y: -lightningCountLabel.frame.height/2 + 2)
     //   self.addChild(progressBar)
        self.addChild(lightningCountLabel)
 //       progressBar.anchorPoint = CGPoint(x: 0, y: 0.5)
       
    }
    
    func setText() {
        lightningCountLabel.setStrokeText("\(Int(lightningCount).description)\\\(Int(maxLightning).description)", size: 22)
    }
    
    func updateProgress() {
        if lightningCount >= maxLightning {return}
        lightningCount += 1
        width+=20
     //   progressBar.run(SKAction.resize(toWidth: CGFloat(width), duration: 0.2))
    }
    
    func clearProgress() {
        lightningCount -= maxLightning
        width = 20*lightningCount
   //     progressBar.run(SKAction.resize(toWidth: CGFloat(width), duration: 0.2))
    }
    
}


extension LightningBar: ButtonType {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let scene = scene else {return}
        if containsTouches(touches: touches, scene: scene, node: self) {
            if lightningCount >= maxLightning {
                clearProgress()
                let lightning = Lightning()
                lightning.position = CGPoint(x: 0, y: 100)
                scene.addChild(lightning)
                thunderSoundPlay()
                lightning.animate()
                scene.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.fadeOut(withDuration: 0.2), SKAction.fadeIn(withDuration: 0.2), SKAction.run {
                    scene.enumerateChildNodes(withName: "ground node") { node, error in
                        if let node = node as? GroundNode {
                            node.enumerateChildNodes(withName: "enemy node") { enemyNode, error in
                                if let enemyNode = enemyNode as? EnemyProtocol {
                                    enemyNode.animateDead()
                                }
                            }
                        }
                    }
                }]))
            }
        }
    }
}


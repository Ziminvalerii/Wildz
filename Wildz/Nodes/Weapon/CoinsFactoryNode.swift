//
//  CoinsFactoryNode.swift
//  Wildz
//
//  Created by Tanya Koldunova on 27.10.2022.
//

import Foundation
import SpriteKit


class CoinsFactoryNode: SKSpriteNode, WeaponProtocol {
    var damage: Int = 0
    
    var strength: Int = 8
    
   
    convenience init() {
        self.init(texture: UserDefaultsValues.currentCoinFactory.texture)
        self.size = CGSize(width: 41, height: 60)
        self.zPosition = 6
        setUpPhysics()
    }
    
    func createBall() {
        guard let scene = scene as? GameScene else {return}
        let coin = CoinNode()
        scene.gameManager.toucheble.append(coin)
        self.addChild(coin)
        let action = SKAction.repeatForever(SKAction.sequence([SKAction.moveTo(y: self.size.width/2 + coin.size.width + 4, duration: 0.5), SKAction.moveTo(y: self.size.width/2 + coin.size.width - 4, duration: 0.5)]))
        coin.run(SKAction.sequence([SKAction.move(to: CGPoint(x: 0, y: self.size.width/2 + coin.size.width), duration: 1.5), action]))
    }
    
    func hitAction() {
        self.run(SKAction.repeatForever(SKAction.sequence([SKAction.run(createBall), SKAction.wait(forDuration: 15)])))
    }
    
    
}

//
//  Lightning.swift
//  Wildz
//
//  Created by Tanya Koldunova on 08.11.2022.
//

import SpriteKit

class Lightning: SKSpriteNode {
    
    let textures: [SKTexture] = [SKTexture(imageNamed: "lightning1"), SKTexture(imageNamed: "lightning2"), SKTexture(imageNamed: "lightning3"), SKTexture(imageNamed: "lightning4")]
    
    convenience init() {
        self.init(imageNamed: "lightning1")
        self.size = CGSize(width: 114, height: 320)
        self.zPosition = 15
        self.name = "lightning"
    }
    
    func animate() {
        self.run(SKAction.sequence([SKAction.animate(with: textures,
                                                     timePerFrame: 0.1,
                                                     resize: false,
                                                     restore: true), SKAction.removeFromParent()]), withKey: "lightning animation")
    }
}

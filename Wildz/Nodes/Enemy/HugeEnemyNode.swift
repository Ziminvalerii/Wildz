//
//  HugeEnemyNode.swift
//  Wildz
//
//  Created by Tanya Koldunova on 02.11.2022.
//

import Foundation
import SpriteKit


class HugeEnemyNode: SKSpriteNode, EnemyProtocol {
    private var types = RewardType.allCases
    var hp: Int = 30
    var type: RewardType = .none
    var walkTextures: [SKTexture] = [SKTexture(imageNamed: "hugeZombieTexture1"), SKTexture(imageNamed: "hugeZombieTexture2"), SKTexture(imageNamed: "hugeZombieTexture3"), SKTexture(imageNamed: "hugeZombieTexture4"), SKTexture(imageNamed: "hugeZombieTexture5"), SKTexture(imageNamed: "hugeZombieTexture6"), SKTexture(imageNamed: "hugeZombieTexture7"), SKTexture(imageNamed: "hugeZombieTexture8"), SKTexture(imageNamed: "hugeZombieTexture9"), SKTexture(imageNamed: "hugeZombieTexture10"), SKTexture(imageNamed: "hugeZombieTexture11"), SKTexture(imageNamed: "hugeZombieTexture12"), SKTexture(imageNamed: "hugeZombieTexture13")]
    
    var deadTextures: [SKTexture] = [SKTexture(imageNamed: "deadHugeZombieTexture1"), SKTexture(imageNamed: "deadHugeZombieTexture2"), SKTexture(imageNamed: "deadHugeZombieTexture3"), SKTexture(imageNamed: "deadHugeZombieTexture4"), SKTexture(imageNamed: "deadHugeZombieTexture5")]
    
    var eatTextures: [SKTexture] = [SKTexture(imageNamed: "eatHugeZombieTexture1"), SKTexture(imageNamed: "eatHugeZombieTexture2"), SKTexture(imageNamed: "eatHugeZombieTexture3"), SKTexture(imageNamed: "eatHugeZombieTexture4"), SKTexture(imageNamed: "eatHugeZombieTexture5"), SKTexture(imageNamed: "eatHugeZombieTexture6"), SKTexture(imageNamed: "eatHugeZombieTexture7")]
    
    
    convenience init() {
        self.init(imageNamed: "hugeZombieTexture1")
        self.size = CGSize(width: 60, height: 80)
        self.zPosition = 5
        self.name = "enemy node"
        setUpPhysics()
        self.type = types[Int.random(in: 0..<types.count)]
        print("enemy type \(type)")
    }
}

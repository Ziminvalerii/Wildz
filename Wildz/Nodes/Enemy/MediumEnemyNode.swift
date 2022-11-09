//
//  MediumEnemyNode.swift
//  Wildz
//
//  Created by Tanya Koldunova on 01.11.2022.
//

import Foundation
import SpriteKit

class MediumEnemyNode: SKSpriteNode, EnemyProtocol {
    private var types = RewardType.allCases
    var hp: Int = 20
    
    var type: RewardType = .none
    
    var walkTextures: [SKTexture] = [SKTexture(imageNamed: "mediumZombieTexture1"), SKTexture(imageNamed: "mediumZombieTexture2"), SKTexture(imageNamed: "mediumZombieTexture3"), SKTexture(imageNamed: "mediumZombieTexture4"), SKTexture(imageNamed: "mediumZombieTexture5"), SKTexture(imageNamed: "mediumZombieTexture6"), SKTexture(imageNamed: "mediumZombieTexture7"), SKTexture(imageNamed: "mediumZombieTexture8"), SKTexture(imageNamed: "mediumZombieTexture9"), SKTexture(imageNamed: "mediumZombieTexture10"), SKTexture(imageNamed: "mediumZombieTexture11"), SKTexture(imageNamed: "mediumZombieTexture12"), SKTexture(imageNamed: "mediumZombieTexture13"), SKTexture(imageNamed: "mediumZombieTexture14"), SKTexture(imageNamed: "mediumZombieTexture15"), SKTexture(imageNamed: "mediumZombieTexture16")]
    
    var deadTextures: [SKTexture] = [SKTexture(imageNamed: "deadMediumZombieTexture1"), SKTexture(imageNamed: "deadMediumZombieTexture2"), SKTexture(imageNamed: "deadMediumZombieTexture3"), SKTexture(imageNamed: "deadMediumZombieTexture4"), SKTexture(imageNamed: "deadMediumZombieTexture5"), SKTexture(imageNamed: "deadMediumZombieTexture6")]
    
    var eatTextures: [SKTexture] = [SKTexture(imageNamed: "eatMediumZombieTexture1"), SKTexture(imageNamed: "eatMediumZombieTexture2"), SKTexture(imageNamed: "eatMediumZombieTexture3"), SKTexture(imageNamed: "eatMediumZombieTexture4"), SKTexture(imageNamed: "eatMediumZombieTexture5"), SKTexture(imageNamed: "eatMediumZombieTexture6"), SKTexture(imageNamed: "eatMediumZombieTexture7"), SKTexture(imageNamed: "eatMediumZombieTexture8"), SKTexture(imageNamed: "eatMediumZombieTexture9")]
    
    convenience init() {
        self.init(imageNamed: "mediumZombieTexture1")
        self.size = CGSize(width: 60, height: 80)
        self.zPosition = 5
        self.name = "enemy node"
        setUpPhysics()
        self.type = types[Int.random(in: 0..<types.count)]
        print("enemy type \(type)")
    }
}

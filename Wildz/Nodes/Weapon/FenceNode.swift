//
//  SandbagNode.swift
//  Wildz
//
//  Created by Tanya Koldunova on 26.10.2022.
//

import SpriteKit

class FenceNode: SKSpriteNode, WeaponProtocol {
    var damage: Int = 0
    var strength: Int = 35
    convenience init() {
        self.init(texture: UserDefaultsValues.currentFence.texture)
        self.size = CGSize(width: 20, height: 61)
        self.zPosition = 6
        setUpPhysics()
    }
    
    func createBall() {
        return
    }
    
    func hitAction() {
        return
    }
}

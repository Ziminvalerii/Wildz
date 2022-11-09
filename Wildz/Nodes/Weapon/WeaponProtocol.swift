//
//  WeaponProtocol.swift
//  Wildz
//
//  Created by Tanya Koldunova on 26.10.2022.
//

import SpriteKit

protocol WeaponProtocol: SKSpriteNode {
    var damage: Int {get set}
    var strength: Int {get set}
    func createBall()
    func setUpPhysics()
    func hitAction()
}

extension WeaponProtocol {
    func setUpPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.pinned = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.collisionBitMask = PhysicsBitMask.enemy.bitMask
        self.physicsBody?.categoryBitMask = PhysicsBitMask.weapon.bitMask
        self.physicsBody?.contactTestBitMask = PhysicsBitMask.enemy.bitMask
    }
}


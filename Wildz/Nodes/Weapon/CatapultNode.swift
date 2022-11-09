//
//  CatapultNode.swift
//  Wildz
//
//  Created by Tanya Koldunova on 26.10.2022.
//

import SpriteKit

class CatapultNode:SKSpriteNode, WeaponProtocol {
    var damage: Int = 3
    var strength: Int = 20
    var applyImplulseTextures: [SKTexture] = UserDefaultsValues.currentCatapult.movedTextures
    convenience init() {
        self.init(texture: UserDefaultsValues.currentCatapult.texture)
        self.size = CGSize(width: 82, height: 65)
        self.zPosition = 6
        setUpPhysics()
    }
    
    func animateApplyImpulse() {
        self.run(SKAction.animate(with: applyImplulseTextures,
                         timePerFrame: 0.1,
                         resize: false,
                         restore: true),
        withKey:"ball animate")
    }
    
    func createBall() {
        guard let scene = scene else {return}
        fallSoundPlay()
        if let parent = self.parent?.parent as? GroundNode {
            guard let enemy = parent.childNode(withName: "enemy node") as? EnemyProtocol else {return}
            animateApplyImpulse()
            let ball = BallNode(type: .catapult)
            let currentXpos =  self.position.x - self.size.width/2 - ball.size.width/2
            ball.position = CGPoint(x: currentXpos, y: self.position.y)
            self.addChild(ball)
            ball.move(toParent: parent)
            print("Impulse: \((enemy.position.x - ball.position.x)/25)")
            ball.applyImpulse(impulse: CGVector(dx: (enemy.position.x - ball.position.x)/47, dy: 20 /*(enemy.position.x - ball.position.x)/25)*/))
        }
        
    }
    
    func hitAction() {
        self.run(SKAction.repeatForever(SKAction.sequence([SKAction.run(createBall), SKAction.wait(forDuration: 2)])))
    }
}

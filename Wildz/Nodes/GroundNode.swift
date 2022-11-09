//
//  GroundNode.swift
//  Wildz
//
//  Created by Tanya Koldunova on 24.10.2022.
//

import SpriteKit

class GroundNode: SKSpriteNode {
    var weapon = [WeaponProtocol]()
    var partsNode: [SKSpriteNode] = [SKSpriteNode]()
    var neededNode: [SKSpriteNode]?
    lazy var groundPart: SKSpriteNode = {
        let node = SKSpriteNode(color: .clear, size: CGSize(width: 700, height: 1))
        node.zPosition = 4
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.pinned = true
        node.physicsBody?.allowsRotation = false
        node.physicsBody?.categoryBitMask = PhysicsBitMask.ground.bitMask
        node.physicsBody?.collisionBitMask = PhysicsBitMask.ball.bitMask
        return node
    }()
    convenience init() {
        self.init(imageNamed: "groundImage")
        self.size = CGSize(width: 700, height: 80)
     //   self.init(color: .clear, size: CGSize(width: 700, height: 80))
        self.zPosition = 3
        spawnSprites()
        groundPart.position = CGPoint(x: 0, y: -self.size.height/2 + groundPart.size.height/2)
        self.addChild(groundPart)
    }
    
    func spawnSprites() {
        let count = Int(self.size.width/80)
        var start = -self.size.width/2+40
        for i in 0..<count {
            let part = SKSpriteNode(color: .clear, size: CGSize(width: 80, height: 80))
            part.position = CGPoint(x: start, y: 0)
            part.zPosition = 4
            part.name = "ground part \(i)"
            partsNode.append(part)
            self.addChild(part)
            start += 80
        }
    }
    
    func appendWeapon(weapon: CannonNode) {
        self.partsNode.first!.addChild(weapon)
        weapon.hitAction()
    }
}

extension GroundNode: ButtonType {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let scene = scene else {return}
        guard let weapon = scene.childNode(withName: "needed weapon") as? WeaponProtocol else {return}
        var neededGround = partsNode.filter { $0.contains(weapon.position)}
        partsNode.forEach { node in
            node.color = .clear
        }
        neededGround.forEach { node in
            node.color =  UIColor(named: "selectColor")!
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let scene = scene else {return}
        guard let weapon = scene.childNode(withName: "needed weapon") as? WeaponProtocol else {return}
        partsNode.map({$0.move(toParent: scene)})
        var neededGround = partsNode.filter { $0.contains(weapon.position)}
        partsNode.forEach { node in
            node.color = .clear
        }
        neededNode = neededGround.count > 0 ? neededGround : nil
        neededGround.last?.color =  UIColor(named: "selectColor")!
        print(neededGround)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let scene = scene else {return}
        guard let weapon = scene.childNode(withName: "needed weapon") as? WeaponProtocol else {return}
        guard let neededNode = neededNode else {return}
   //     let
        if neededNode.count > 0 {
            var hasSamePos: Bool = false
            neededNode.forEach { node in
                self.enumerateChildNodes(withName: "enemy node") { enemyNode, error in
                    enemyNode.move(toParent: node)
                    let enemyNodePos = enemyNode.position
                    enemyNode.move(toParent: self)
                    let xRange = -40.0 ... 40.0
                    if xRange.contains(enemyNodePos.x) {
                        hasSamePos = true
                        return
                    }
                }
                if node.children.isEmpty == true && !hasSamePos {
                    weapon.setUpPhysics()
                    weapon.zPosition = 6
                    weapon.move(toParent: node)
                    weapon.position = CGPoint(x: 0, y: 0)
                    weapon.hitAction()
                }
            }
        } else {
            weapon.removeFromParent()
        }
        partsNode.forEach { node in
            node.color = .clear
        }
        partsNode.map({$0.move(toParent: self)})
        
    }
}

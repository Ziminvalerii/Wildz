//
//  ChooseNode.swift
//  Wildz
//
//  Created by Tanya Koldunova on 25.10.2022.
//

import SpriteKit


class ChooseNode: SKSpriteNode {
    var chooseWeapon: Bool = false
    var buttons: [ChooseButton] = [ChooseButton]()
    var currentPrice: Int = 0
    convenience init() {
        self.init(color: .clear, size: CGSize(width: 312, height: 70))
        spawnButtons()
    }
    
    func spawnButtons() {
        var type = ChooseButtonType.allCases
        let spacebetween: CGFloat = (self.size.width - (70 * CGFloat(type.count)))/(CGFloat(type.count))
        var xPos:CGFloat = -self.size.width/2 + 70/2 + spacebetween
        for i in 0..<type.count {
            let node = ChooseButton(type: type[i])
            node.position = CGPoint(x: xPos, y: 0)
            node.name = "weaponButton"
            self.addChild(node)
            buttons.append(node)
            xPos += 70+spacebetween
        }
    }
}

extension ChooseNode: ButtonType {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let scene = scene as? GameScene else {return}
        if containsTouchesWithChilds(touches: touches, scene: scene, nodeName: "weaponButton") {
            if let touch = touches.first {
                print("began")
                let point = touch.location(in: scene)
                if let node = nodeAcceptedTouch(touches: touches, scene: scene) as? ChooseButton {
                    if node.childNode(withName: "cover node") == nil && node.type.coinsCount <= scene.gameManager.coinsCount {
                        currentPrice =  node.type.coinsCount
                        
                        var weaponNode = node.type.node
                        weaponNode.zPosition = 30
                        weaponNode.name = "needed weapon"
                        weaponNode.position = point
                        weaponNode.physicsBody = nil
                        scene.addChild(weaponNode)
                        chooseWeapon = true
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let scene = scene as? GameScene else {return}
        guard let weaponNode = scene.childNode(withName: "needed weapon") as? WeaponProtocol else {return}
        if chooseWeapon {
            if let touch = touches.first {
                print("moved")
                let point = touch.location(in: scene)
                weaponNode.position = point
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let scene = scene as? GameScene else {return}
        if chooseWeapon {
            chooseWeapon = false
            if let choosenWeapone = scene.childNode(withName: "needed weapon") as? WeaponProtocol {
                choosenWeapone.removeFromParent()
            } else {
                scene.gameManager.coinsCount -= currentPrice
                buttons.map({$0.wait()})
            }
        }
    }
}



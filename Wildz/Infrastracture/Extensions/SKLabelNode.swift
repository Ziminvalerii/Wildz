//
//  SKLabelNode.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 06.10.2022.
//

import SpriteKit

extension SKLabelNode {
    convenience init(text: String, size: CGFloat, shadow: UIColor) {
        let attrText = NSAttributedString(string: text, attributes: [.font : UIFont(name: "Arial Rounded MT Bold", size: size)!, .foregroundColor: UIColor.green])
        self.init(attributedText: attrText)
        let shadowText = NSAttributedString(string: text, attributes: [.font : UIFont(name: "Arial Rounded MT Bold", size: size)!, .foregroundColor: UIColor.black])
        let shadowNode = SKLabelNode(attributedText: shadowText)
        shadowNode.zPosition = self.zPosition - 1
       
        shadowNode.position = CGPoint(x: 4, y: -2)
        shadowNode.alpha = 0.5
        self.addChild(shadowNode)
    }
    
     convenience init(_ text: String, size: CGFloat) {
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont(name: "ComicSansMS-Bold", size: size)!,
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeWidth: -4.0
        ];
        let textWithStroke = NSAttributedString(
            string: text,
            attributes: attributes
        )
        self.init(attributedText: textWithStroke)
    }
    
    func setStrokeText(_ text: String, size: CGFloat) {
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont(name: "ComicSansMS-Bold", size: size)!,
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeWidth: -4.0
        ];
        let textWithStroke = NSAttributedString(
            string: text,
            attributes: attributes
        )
        self.attributedText = textWithStroke
    }
}

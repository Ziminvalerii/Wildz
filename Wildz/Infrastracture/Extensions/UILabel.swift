//
//  UILabel.swift
//  Wildz
//
//  Created by Tanya Koldunova on 01.11.2022.
//

import Foundation
import UIKit


extension UILabel {
    func setStrokeText(_ text: String) {
        let attributes: [NSAttributedString.Key: Any] = [
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
    func strokeTextWithImage(_ text: String, imageName: String = "smallCoin.png") {
        let fullString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.strokeColor: UIColor.black, NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.strokeWidth: -4.0])
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = UIImage(named: imageName)
        let image1String = NSAttributedString(attachment: image1Attachment)
        fullString.append(image1String)
        self.attributedText = fullString
    }

}


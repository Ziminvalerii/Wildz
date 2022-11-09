//
//  UIButton.swift
//  Wildz
//
//  Created by Tanya Koldunova on 01.11.2022.
//

import Foundation
import UIKit


extension UIButton {
    func setStrokeTitle(_ text: String, size: CGFloat = 17) {
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.strokeWidth: -4.0,
            NSAttributedString.Key.font: UIFont(name: "ComicSansMS-Bold", size: size)!
        ];
        let textWithStroke = NSAttributedString(
            string: text,
            attributes: attributes
        )
        DispatchQueue.main.async {
            self.setAttributedTitle(textWithStroke, for: .normal)
        }
        
    }
}

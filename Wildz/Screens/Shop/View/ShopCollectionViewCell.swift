//
//  ShopCollectionViewCell.swift
//  Wildz
//
//  Created by Tanya Koldunova on 31.10.2022.
//

import UIKit
import StoreKit

class ShopCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerImageView: UIImageView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    var model: ShopValuesModelProtocol!
    func configure(model: ShopValuesModelProtocol, realMoney: ProductSub?) {
        itemImageView.image = model.image
        if let price = realMoney?.price {
            priceLabel.text = price.description//model.price.description
        } else {
            if model.price == 0 {
                priceLabel.text = "--"
            } else {
                priceLabel.text = model.price.description
            }
        }
       
        self.model = model
    }
    
}

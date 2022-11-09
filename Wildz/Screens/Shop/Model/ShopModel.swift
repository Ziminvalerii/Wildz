//
//  ShopModel.swift
//  Wildz
//
//  Created by Tanya Koldunova on 31.10.2022.
//

import Foundation
import UIKit
import SpriteKit


enum ShopModel: CaseIterable {
    case coinFactory
    case cannon
    case catapult
    case fence
    
    var values: [ShopValuesModelProtocol] {
        switch self {
        case .coinFactory:
            return CoinFactoryModel.allCases
        case .cannon:
            return CannonModel.allCases
        case .catapult:
            return CatapultModel.allCases
        case .fence:
            return FenceModel.allCases
        }
    }
}

protocol ShopValuesModelProtocol {
    var image: UIImage {get}
    var price: Int {get}
    var texture: SKTexture {get}
    var purchaseIdentifier: String? {get}
}

enum CoinFactoryModel: String, CaseIterable, ShopValuesModelProtocol {
case coinFactory1 = "com.coinFactory1.key"
    
    var image: UIImage {
        switch self {
        case .coinFactory1:
            return UIImage(named: "coinsFactory")!
        }
    }
    
    var texture: SKTexture {
        switch self {
        case .coinFactory1:
            return SKTexture(imageNamed: "coinsFactory")
        }
    }
    
    var price: Int {
        switch self {
        case .coinFactory1:
            return 50
        }
    }
    
    var purchaseIdentifier: String? {
        switch self {
        case .coinFactory1:
            return nil
        }
    }
}

enum CannonModel: String, CaseIterable, ShopValuesModelProtocol {
    case cannon1 = "com.cannon1.key"
    case cannon2 = "com.cannon2.key"
    case cannon3 = "com.cannon3.key"
    case cannon4 = "com.cannon4.key"
    
    var image: UIImage {
        switch self {
        case .cannon1:
            return UIImage(named: "cannon1")!
        case .cannon2:
            return UIImage(named: "cannon2")!
        case .cannon3:
            return UIImage(named: "cannon3")!
        case .cannon4:
            return UIImage(named: "cannon4")!
        }
    }
    
    var texture: SKTexture {
        switch self {
        case .cannon1:
            return SKTexture(imageNamed: "cannon1")
        case .cannon2:
            return SKTexture(imageNamed: "cannon2")
        case .cannon3:
            return SKTexture(imageNamed: "cannon3")
        case .cannon4:
            return SKTexture(imageNamed: "cannon4")
        }
    }
    
    var price: Int {
        switch self {
        case .cannon1:
            return 50
        case .cannon2:
            return 50
        case .cannon3:
            return 50
        case .cannon4:
            return 0
        }
    }
    
    var purchaseIdentifier: String? {
        switch self {
        case .cannon1:
            return nil
        case .cannon2:
            return nil
        case .cannon3:
            return nil
        case .cannon4:
            return "com.bestCannon.character"
        }
    }
}

enum CatapultModel: String, CaseIterable, ShopValuesModelProtocol {
case catapult1 = "com.catapult1.key"
case catapult2 = "com.catapult2.key"
case catapult3 = "com.catapult3.key"
    
    var image: UIImage {
        switch self {
        case .catapult1:
            return UIImage(named: "catapultTexture1")!
        case .catapult2:
            return UIImage(named: "catapult2Texture1")!
        case .catapult3:
            return UIImage(named: "catapult3Texture1")!
        }
    }
    
    var price: Int {
        switch self {
        case .catapult1:
            return 50
        case .catapult2:
            return 50
        case .catapult3:
            return 0
        }
    }
    
    var texture: SKTexture {
        switch self {
        case .catapult1:
            return SKTexture(imageNamed: "catapultTexture1")
        case .catapult2:
            return SKTexture(imageNamed: "catapult2Texture1")
        case .catapult3:
            return SKTexture(imageNamed: "catapult3Texture1")
        }
    }
    
    var movedTextures: [SKTexture] {
        switch self {
        case .catapult1:
            return [SKTexture(imageNamed: "catapultTexture1"), SKTexture(imageNamed: "catapultTexture2"), SKTexture(imageNamed: "catapultTexture3"), SKTexture(imageNamed: "catapultTexture4")]
        case .catapult2:
            return [SKTexture(imageNamed: "catapult2Texture1"), SKTexture(imageNamed: "catapult2Texture2"), SKTexture(imageNamed: "catapult2Texture3"), SKTexture(imageNamed: "catapult2Texture4")]
        case .catapult3:
            return [SKTexture(imageNamed: "catapult3Texture1"), SKTexture(imageNamed: "catapult3Texture2"), SKTexture(imageNamed: "catapult3Texture3"), SKTexture(imageNamed: "catapult3Texture4")]
        }
    }
    var purchaseIdentifier: String? {
        switch self {
        case .catapult1:
            return nil
        case .catapult2:
            return nil
        case .catapult3:
            return "com.bestCatapult.character"
        }
    }
}

enum FenceModel: String, CaseIterable, ShopValuesModelProtocol {
    case fence1 = "com.fence1.key"
    case fence2 = "com.fence2.key"
    case fence3 = "com.fence3.key"
    case fence4 = "com.fence4.key"
    case fence5 = "com.fence5.key"
    
    var image: UIImage {
        switch self {
        case .fence1:
            return UIImage(named: "fence1")!
        case .fence2:
            return UIImage(named: "fence2")!
        case .fence3:
            return UIImage(named: "fence3")!
        case .fence4:
            return UIImage(named: "fence4")!
        case .fence5:
            return UIImage(named: "fence5")!
        }
    }
    
    var price: Int {
        switch self {
        case .fence1:
            return 50
        case .fence2:
            return 50
        case .fence3:
            return 50
        case .fence4:
            return 50
        case .fence5:
            return 0
        }
    }
    
    var texture: SKTexture {
        switch self {
        case .fence1:
            return SKTexture(imageNamed: "fence1")
        case .fence2:
            return SKTexture(imageNamed: "fence2")
        case .fence3:
            return SKTexture(imageNamed: "fence3")
        case .fence4:
            return SKTexture(imageNamed: "fence4")
        case .fence5:
            return SKTexture(imageNamed: "fence5")
        }
    }
    
    var purchaseIdentifier: String? {
        switch self {
        case .fence1:
            return nil
        case .fence2:
            return nil
        case .fence3:
            return nil
        case .fence4:
            return nil
        case .fence5:
            return "com.bestFence.character"
        }
    }
}

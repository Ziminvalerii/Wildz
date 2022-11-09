//
//  UserDefaultsValues.swift
//  Wildz
//
//  Created by Tanya Koldunova on 24.10.2022.
//

import Foundation
import GameKit

public struct UserDefaultsValues {
    enum Keys {
        static let musicOffKey = "com.musicOff.key"
        static let soundOffKey = "com.soundOff.key"
        static let vibrationOffKey = "com.vibrationOff.key"
        static let brightnessKey = "com.brightness.key"
        static let coinsCountKey = "com.coinsCount.key"
        static let bonusDateKey = "com.bonusDate.key"
        static let bestScoreKey = "com.bestScore.key"
        static let stakeKey = "com.stake.key"
        static let availableCoinFactoryKey = "com.availableCoinFactory.key"
        static let currentCoinFactoryKey = "com.currentCoinFactory.key"
        static let availableCannonKey = "com.availableCannon.key"
        static let currentCannonKey = "com.currentCannon.key"
        static let availableCatapultKey = "com.availableCatapult.key"
        static let currentCatapultKey = "com.currentCatapult.key"
        static let availableFencesKey = "com.availableFences.key"
        static let currentFencesKey = "com.currentFenses.key"
    //    static let bonusDateKey = "com.bonusDate.key"
    }
    
    static var musicOff: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.musicOffKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.musicOffKey)
        }
    }
    
    static var soundOff: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.soundOffKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.soundOffKey)
        }
    }
    
    static var vibrationOff: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.vibrationOffKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.vibrationOffKey)
        }
    }
    
    static var coinsCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: Keys.coinsCountKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.coinsCountKey)
        }
    }
    
    static var brightness: Float {
        get {
            return UserDefaults.standard.float(forKey: Keys.brightnessKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.brightnessKey)
        }
    }
    
    static var availableCoinFactoryKeys: [String] {
        get {
            return UserDefaults.standard.object(forKey: Keys.availableCoinFactoryKey) as? [String] ?? [CoinFactoryModel.coinFactory1.rawValue]
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.availableCoinFactoryKey)
        }
    }
    
    static var availableCoinFactory: [CoinFactoryModel] {
        get {
            var availableCoinFactory = [CoinFactoryModel]()
            UserDefaultsValues.availableCoinFactoryKeys.forEach { m in
                if let model = CoinFactoryModel(rawValue: m) {
                    availableCoinFactory.append(model)
                }
            }
            return availableCoinFactory
        } set {
            var coinFactoryKeys = newValue.map({return $0.rawValue})
            if coinFactoryKeys.count == 0 {
                coinFactoryKeys.append(CoinFactoryModel.coinFactory1.rawValue)
            }
            UserDefaultsValues.availableCoinFactoryKeys = coinFactoryKeys
        }
    }
    static var currentCoinFactoryKey: String {
        get {
            UserDefaults.standard.string(forKey: Keys.currentCoinFactoryKey) ?? CoinFactoryModel.coinFactory1.rawValue
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.currentCoinFactoryKey)
        }
    }
    
    static var currentCoinFactory: CoinFactoryModel {
        get {
            return CoinFactoryModel(rawValue: UserDefaultsValues.currentCoinFactoryKey)!
        } set {
            UserDefaultsValues.currentCoinFactoryKey = newValue.rawValue
        }
    }
    
    static var availableCannonKeys: [String] {
        get {
            return UserDefaults.standard.object(forKey: Keys.availableCannonKey) as? [String] ?? [CannonModel.cannon1.rawValue]
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.availableCannonKey)
        }
    }
    
    static var availableCannons: [CannonModel] {
        get {
            var availableCannon = [CannonModel]()
            UserDefaultsValues.availableCannonKeys.forEach { m in
                if let model = CannonModel(rawValue: m) {
                    availableCannon.append(model)
                }
            }
            return availableCannon
        } set {
            var cannonKeys = newValue.map({return $0.rawValue})
            if cannonKeys.count == 0 {
                cannonKeys.append(CannonModel.cannon1.rawValue)
            }
            UserDefaultsValues.availableCannonKeys = cannonKeys
        }
    }
    
    static var currentCannonKey: String {
        get {
            UserDefaults.standard.string(forKey: Keys.currentCannonKey) ?? CannonModel.cannon1.rawValue
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.currentCannonKey)
        }
    }
    
    static var currentCannon: CannonModel  {
        get {
            return CannonModel(rawValue: UserDefaultsValues.currentCannonKey)!
        } set {
            UserDefaultsValues.currentCannonKey = newValue.rawValue
        }
    }
    
    
    static var availableCatapultKeys: [String] {
        get {
            return UserDefaults.standard.object(forKey: Keys.availableCatapultKey) as? [String] ?? [CatapultModel.catapult1.rawValue]
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.availableCatapultKey)
        }
    }
    
    static var availablCatapults: [CatapultModel] {
        get {
            var availableCatapults = [CatapultModel]()
            UserDefaultsValues.availableCatapultKeys.forEach { m in
                if let model = CatapultModel(rawValue: m) {
                    availableCatapults.append(model)
                }
            }
            return availableCatapults
        } set {
            var catapultsKeys = newValue.map({return $0.rawValue})
            if catapultsKeys.count == 0 {
                catapultsKeys.append(CatapultModel.catapult1.rawValue)
            }
            UserDefaultsValues.availableCatapultKeys = catapultsKeys
        }
    }
    static var currentCatapultKey: String {
        get {
            UserDefaults.standard.string(forKey: Keys.currentCatapultKey) ?? CatapultModel.catapult1.rawValue
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.currentCatapultKey)
        }
    }
    
    static var currentCatapult: CatapultModel {
        get {
            return CatapultModel(rawValue: UserDefaultsValues.currentCatapultKey)!
        } set {
            UserDefaultsValues.currentCatapultKey = newValue.rawValue
        }
    }
    
    static var availableFencesKeys: [String] {
        get {
            return UserDefaults.standard.object(forKey: Keys.availableFencesKey) as? [String] ?? [FenceModel.fence1.rawValue]
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.availableFencesKey)
        }
    }
    
    static var availablFences: [FenceModel] {
        get {
            var availablFences = [FenceModel]()
            UserDefaultsValues.availableFencesKeys.forEach { m in
                if let model = FenceModel(rawValue: m) {
                    availablFences.append(model)
                }
            }
            return availablFences
        } set {
            var fencesKeys = newValue.map({return $0.rawValue})
            if fencesKeys.count == 0 {
                fencesKeys.append(FenceModel.fence1.rawValue)
            }
            UserDefaultsValues.availableFencesKeys = fencesKeys
        }
    }
    static var currentFenceKey: String {
        get {
            UserDefaults.standard.string(forKey: Keys.currentFencesKey) ?? FenceModel.fence1.rawValue
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.currentFencesKey)
        }
    }
    
    static var currentFence: FenceModel {
        get {
            return FenceModel(rawValue: UserDefaultsValues.currentFenceKey)!
        } set {
            UserDefaultsValues.currentFenceKey = newValue.rawValue
        }
    }
    
    static var bonusDate: Date {
        get {
            if let date = UserDefaults.standard.object(forKey: Keys.bonusDateKey) {
                return date as! Date
            } else {
                let date = Date()
                UserDefaultsValues.bonusDate = date
                return date
            }
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.bonusDateKey)
        }
    }
    
    static var bestScore: TimeInterval {
        get {
            UserDefaults.standard.object(forKey: Keys.bestScoreKey) as? TimeInterval ?? 0.0
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.bestScoreKey)
            if GKLocalPlayer.local.isAuthenticated {
                let scoreReporter = GKScore(leaderboardIdentifier: "com.jonokoltd.bwin.Leaderboard")
                scoreReporter.value = Int64(newValue)
                GKScore.report([scoreReporter])
            }
        }
    }
}

//
//  StartViewController.swift
//  Wildz
//
//  Created by Tanya Koldunova on 26.10.2022.
//

import UIKit
import SpriteKit
import GameKit

class StartViewController: BaseViewController<StartPresenterProtocol>, StartViewProtocol {
    var showBonus: Bool = false {
        didSet {
            bonusView.isHidden = !showBonus
        }
    }
    @IBOutlet weak var brightnessLabel: UILabel! {
        didSet {
            brightnessLabel.setStrokeText("Brightness")
        }
    }
    var router: RouterProtocol!
    @IBOutlet weak var bonusView: UIView!
    @IBOutlet weak var bonusTitleLabel: UILabel!
    @IBOutlet weak var showBonnusButton: UIButton!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var brightnessSlider: UISlider! {
        didSet {
            brightnessSlider.setThumbImage(UIImage(named: "tumbImage")!, for: .normal)
            brightnessSlider.value = UserDefaultsValues.brightness
        }
    }
    @IBOutlet weak var bonusDecriptionLabel: UILabel!
    @IBOutlet weak var bonusRewardLabel: UILabel!
    @IBOutlet weak var soundCell: SettingsCell! {
        didSet {
            soundCell.configure(model: .sound)
        }
    }
    @IBOutlet weak var musicCell: SettingsCell! {
        didSet {
            musicCell.configure(model: .music)
        }
    }
    @IBOutlet weak var vibrationCell: SettingsCell! {
        didSet {
            vibrationCell.configure(model: .vibration)
        }
    }
    @IBOutlet weak var privacyPolicyCell: SettingsCell! {
        didSet {
            privacyPolicyCell.configure(model: .privacyPolicy)
            privacyPolicyCell.router = router
        }
    }
    @IBOutlet weak var gameCenterButton: UIButton! {
        didSet {
            gameCenterButton.setStrokeTitle("Game Center")
        }
    }
    @IBOutlet weak var startButton: UIButton! {
        didSet {
            startButton.setStrokeTitle("Start")
        }
    }
    @IBOutlet weak var shopButton: UIButton! {
        didSet {
            shopButton.setStrokeTitle("Shop")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "StartScene") as? StartScene {
                scene.size = view.bounds.size
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = true
          //  view.showsPhysics = true
            view.showsNodeCount = true
            settingsView.isHidden = true
        }
        for font in UIFont.familyNames {
            print(UIFont.fontNames(forFamilyName: font))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showBonus = false
        configureBonusView()
        presenter.time = UserDefaultsValues.bonusDate.timeIntervalSince1970 - Date().timeIntervalSince1970
        presenter.startTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.stop()
    }
    
    func configureBonusView() {
        bonusTitleLabel.setStrokeText(Date().timeIntervalSince1970 > UserDefaultsValues.bonusDate.timeIntervalSince1970 ? "Congratulation" : "Wait some time")
        bonusDecriptionLabel.setStrokeText(Date().timeIntervalSince1970 > UserDefaultsValues.bonusDate.timeIntervalSince1970 ? "You have recieved daily bonus " : "You have already recieved daily bonus. To recieve it again you need to wait")
        let fullString = NSMutableAttributedString(string: Date().timeIntervalSince1970 > UserDefaultsValues.bonusDate.timeIntervalSince1970 ? "50" : presenter.timeString(time: presenter.time), attributes: [NSAttributedString.Key.strokeColor: UIColor.black, NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.strokeWidth: -4.0])
        if Date().timeIntervalSince1970 > UserDefaultsValues.bonusDate.timeIntervalSince1970 {
            showBonnusButton.doGlowAnimation(withColor: .white, withEffect: .big)
            let image1Attachment = NSTextAttachment()
            image1Attachment.image = UIImage(named: "smallCoin.png")
            let image1String = NSAttributedString(attachment: image1Attachment)
            fullString.append(image1String)
        } else {
            showBonnusButton.removeGlowAnimation()
        }
        bonusRewardLabel.attributedText = fullString
    }
    
    func setBonusTime() {
        let fullString = NSMutableAttributedString(string: Date().timeIntervalSince1970 > UserDefaultsValues.bonusDate.timeIntervalSince1970 ? "50" : presenter.timeString(time: presenter.time), attributes: [NSAttributedString.Key.strokeColor: UIColor.black, NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.strokeWidth: -4.0])
        bonusRewardLabel.attributedText = fullString
    }
    
    private func authenticatePlayer() {
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = { (vc, error) in
            if let vc = vc {
                self.present(vc, animated: true)
            } else {
                self.router.goToGameCenter()
            }
        }
    }
    
    
    @IBAction func brightnessSliderValueChanged(_ sender: Any) {
        UserDefaultsValues.brightness = Float(brightnessSlider.value)
        UIScreen.main.brightness = CGFloat(UserDefaultsValues.brightness)
    }
    @IBAction func settingsButtonPressed(_ sender: Any) {
        pressedButtonSound()
        settingsView.isHidden = false
    }
    @IBAction func instractionButtonPressed(_ sender: Any) {
        pressedButtonSound()
        router.goToInstruction()
    }
    @IBAction func startButtonPressed(_ sender: Any) {
        pressedButtonSound()
        router.goToGame()
    }
    @IBAction func gameCenterPressed(_ sender: Any) {
        pressedButtonSound()
        if GKLocalPlayer.local.isAuthenticated {
            router.goToGameCenter()
        } else {
            authenticatePlayer()
        }
    }
    @IBAction func hideSettingButtonPressed(_ sender: Any) {
        pressedButtonSound()
        settingsView.isHidden = true
    }
    @IBAction func shopButtonPressed(_ sender: Any) {
        pressedButtonSound()
        router.goToShop()
    }
    @IBAction func showBonusButtonPressed(_ sender: Any) {
        pressedButtonSound()
        showBonus = true
        if Date().timeIntervalSince1970 > UserDefaultsValues.bonusDate.timeIntervalSince1970 {
            congratulationSoundPlay()
        //    bonusAnimationView.play()
            UserDefaultsValues.coinsCount += 50
        }
    }
    @IBAction func hideBonusButtonPressed(_ sender: Any) {
        pressedButtonSound()
        if Date().timeIntervalSince1970 > UserDefaultsValues.bonusDate.timeIntervalSince1970 {
            UserDefaultsValues.bonusDate = Date().addingTimeInterval(86400)
            presenter.time = UserDefaultsValues.bonusDate.timeIntervalSince1970 - Date().timeIntervalSince1970
            presenter.startTimer()
        }
        showBonus = false
        configureBonusView()
    }
}

extension StartViewController: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true)
    }
}


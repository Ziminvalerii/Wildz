//
//  InstructionViewController.swift
//  Wildz
//
//  Created by Tanya Koldunova on 04.11.2022.
//

import UIKit

class InstructionViewController: UIViewController {
    
    var router: RouterProtocol!
    @IBOutlet weak var coinFactoryPriceLabel: UILabel! {
        didSet {
            coinFactoryPriceLabel.strokeTextWithImage("25")
        }
    }
    @IBOutlet weak var cannonPriceLabel: UILabel! {
        didSet {
            cannonPriceLabel.strokeTextWithImage("50")
        }
    }
    @IBOutlet weak var catapultPriceLabel: UILabel! {
        didSet {
            catapultPriceLabel.strokeTextWithImage("100")
        }
    }
    @IBOutlet weak var fencePriceLabel: UILabel! {
        didSet {
            fencePriceLabel.strokeTextWithImage("50")
        }
    }
    @IBOutlet weak var castleImageView: UIImageView!
    @IBOutlet weak var zombieImageView: UIImageView!
    @IBOutlet weak var tip1Label: UILabel! {
        didSet {
            tip1Label.isHidden = true
        }
    }
    @IBOutlet weak var tip2Label: UILabel! {
        didSet {
            tip2Label.isHidden = true
        }
    }
    @IBOutlet weak var tip3Label: UILabel! {
        didSet {
            tip3Label.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = UIColor.clear

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
            self.animateLabel(self.tip1Label)
            self.zombieImageView.doGlowAnimation(withColor: .yellow)
            self.zombieImageView.doGlowAnimation(withColor: .yellow)
        })
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0, execute: {
            self.animateLabel(self.tip2Label)
        })
        DispatchQueue.main.asyncAfter(deadline: .now()+3.0, execute: {
            self.animateLabel(self.tip3Label)
        })
    }
    
    func animateLabel(_ label: UILabel) {
        UIView.animate(withDuration: 1.0, animations: {
            label.isHidden = false
        })
        label.doGlowAnimation(withColor: .yellow)
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        pressedButtonSound()
        router.back()
    }
}

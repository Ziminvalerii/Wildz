//
//  GameViewController.swift
//  Wildz
//
//  Created by Tanya Koldunova on 24.10.2022.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var router: RouterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                scene.size = view.bounds.size
                scene.scaleMode = .aspectFill
                scene.parentVC = self
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = true
          //  view.showsPhysics = true
            view.showsNodeCount = true
        }
    }
    
    func dissmiss() {
        self.router?.dissmiss()
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.landscapeRight, .landscapeLeft]
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

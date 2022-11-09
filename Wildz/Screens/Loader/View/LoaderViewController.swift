//
//  LoaderViewController.swift
//  Wildz
//
//  Created by Tanya Koldunova on 03.11.2022.
//

import UIKit
import Lottie

class LoaderViewController: UIViewController {
    var router: RouterProtocol!
    @IBOutlet weak var progressView: CustomProgreeView!
    @IBOutlet weak var animationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.animate()
        animationView.play()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now()+2.5, execute: {
            let rootNavVC = NavigationController()
            self.router.navigationController = rootNavVC
            self.router.start()
            (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = rootNavVC
        })
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

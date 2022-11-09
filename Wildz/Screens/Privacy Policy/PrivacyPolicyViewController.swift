//
//  PrivacyPolicyViewController.swift
//  Wildz
//
//  Created by Tanya Koldunova on 09.11.2022.
//

import UIKit

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController {
    var router: RouterProtocol
    lazy var dissmissButton : UIButton = {
          let button = UIButton(frame: CGRect(x: 16, y: 16, width: 24, height: 24))
          let image = UIImage(named: "cross")!
          button.setBackgroundImage(image, for: .normal)
          button.addTarget(self, action: #selector(dissmissButtonTapped), for: .touchUpInside)
          return button
      }()
    private var url: URL
    
    init(url: URL, router: RouterProtocol) {
        self.url = url
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = WKWebView(frame: self.view.bounds)
        webView.load(URLRequest(url: url))
        self.view.addSubview(webView)
        self.view.addSubview(dissmissButton)
        // Do any additional setup after loading the view.
    }
    
    @objc func dissmissButtonTapped() {
           router.dissmiss()
       }

    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

}

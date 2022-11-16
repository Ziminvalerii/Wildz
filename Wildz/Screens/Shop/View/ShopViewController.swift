//
//  ShopViewController.swift
//  Wildz
//
//  Created by Tanya Koldunova on 31.10.2022.
//

import UIKit

class ShopViewController: BaseViewController<ShopPresenterProtocol>, ShopViewProtocol {
    var router: RouterProtocol!
    @IBOutlet weak var restoreButton: UIButton!
    @IBOutlet weak var shopTitle: UILabel! {
        didSet {
            shopTitle.setStrokeText("Shop")
        }
    }
    
    @IBOutlet weak var shopCollectionView: UICollectionView! {
        didSet {
            shopCollectionView.delegate = presenter
            shopCollectionView.dataSource = presenter
            let layout = UPCarouselFlowLayout()
            layout.itemSize = CGSize(width: 150, height: 160)
            layout.scrollDirection = .horizontal
            shopCollectionView.collectionViewLayout = layout
        }
    }
    @IBOutlet weak var coinsCountLabel: UILabel! {
        didSet {
            coinsCountLabel.strokeTextWithImage(UserDefaultsValues.coinsCount.description)
        }
    }
    
    @IBOutlet weak var customSegmentControl: CustomSegmentedControl! {
        didSet {
            customSegmentControl.selectorTextColor = .white
            customSegmentControl.selectorViewColor = .white
            customSegmentControl.textColor = .white
            customSegmentControl.setButtonTitles(buttonTitles: ["Cannon", "Catapult", "Fence", "Coins factory"])
            customSegmentControl.delegate = self
        }
    }
 //   @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var buyButton: UIButton! {
        didSet {
            buyButton.setStrokeTitle("Buy", size: 22)
        }
    }
    
    private var buttonActionType: BuyButtonActionType = .current {
        didSet {
            buyButton.setStrokeTitle(buttonActionType.buttonTitle, size: 22)
            if buttonActionType == .buy {
                if UserDefaultsValues.coinsCount < currentModel?.price ?? 0 {
                    buyButton.alpha = 0.5
                } else {
                    buyButton.alpha = 1
                }
            } else if buttonActionType == .buyForMoney {
                guard let currentModel = currentModel else {buyButton.alpha = 0.5; return}
                if presenter.checkIdentifier(model: currentModel) != nil {
                    buyButton.alpha = 1
                } else {
                    buyButton.alpha = 0.5
                }
            } else {
                DispatchQueue.main.async {
                    self.buyButton.alpha = 1
                }
               
            }
        }
    }
    private var currentModel: ShopValuesModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonActionType = .current
        self.navigationController?.navigationBar.isHidden = true 
        // Do any additional setup after loading the view.
    }
    
    func showBuyAlert(currentModel: ShopValuesModelProtocol?) {
        let alertController = UIAlertController(title: "Are you sure you want buy this item?", message: "", preferredStyle: .alert)
        let buyAction = UIAlertAction(title: "Yes", style: .default) { action in
            guard UserDefaultsValues.coinsCount >= currentModel?.price ?? 0 else {
                alertController.dismiss(animated: true)
                self.showAlert()
                return
            }
            if let currentModel = currentModel as? CannonModel {
                 UserDefaultsValues.availableCannons.append(currentModel)
                UserDefaultsValues.currentCannon = currentModel
            } else if let currentModel = currentModel as? CatapultModel {
                UserDefaultsValues.availablCatapults.append(currentModel)
                UserDefaultsValues.currentCatapult = currentModel
            } else if let currentModel = currentModel as? FenceModel {
                UserDefaultsValues.availablFences.append(currentModel)
                UserDefaultsValues.currentFence = currentModel
            }
            if let currentModel = currentModel {
                self.configureShopButton(currentModel: currentModel)
            }
            UserDefaultsValues.coinsCount -= currentModel?.price ?? 0
            self.coinsCountLabel.strokeTextWithImage(UserDefaultsValues.coinsCount.description)
            alertController.dismiss(animated: true)
        }
        let cancel = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel)
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(cancel)
        alertController.addAction(buyAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "You don`t have enough coins", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Got it", style: UIAlertAction.Style.cancel)
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func paymenFailedAlert() {
        let alertController = UIAlertController(title: "Something went wrong", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Got it", style: UIAlertAction.Style.cancel)
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getSegmentIndex()->Int {
       // return segmentControl.selectedSegmentIndex
        return customSegmentControl.selectedIndex
    }
    
    func getShopCollectionView() -> UICollectionView {
        return shopCollectionView
    }
    func reloadData() {
        shopCollectionView.reloadData()
    }
    
    func configureShopButton(currentModel: ShopValuesModelProtocol) {
        self.currentModel = currentModel
        if let currentModel = currentModel as? CoinFactoryModel {
            buttonActionType = .current
        } else if let currentModel = currentModel as? CannonModel {
            if currentModel == UserDefaultsValues.currentCannon {
                buttonActionType = .current
            } else if UserDefaultsValues.availableCannons.contains(where: {$0.rawValue == currentModel.rawValue}) {                buttonActionType = .get
            } else if currentModel.purchaseIdentifier != nil /*let purchaseModel = presenter.checkIdentifier(model: currentModel)*/ {
                buttonActionType = .buyForMoney
            } else {
                buttonActionType = .buy
            }
        } else if let currentModel = currentModel as? CatapultModel {
            if currentModel == UserDefaultsValues.currentCatapult {
                buttonActionType = .current
            } else if UserDefaultsValues.availablCatapults.contains(where: {$0.rawValue == currentModel.rawValue}) {
                buttonActionType = .get
            } else if currentModel.purchaseIdentifier != nil /*let purchaseModel = presenter.checkIdentifier(model: currentModel)*/ {
                buttonActionType = .buyForMoney
            } else {
                buttonActionType = .buy
            }
        } else if let currentModel = currentModel as? FenceModel {
            if currentModel == UserDefaultsValues.currentFence {
                buttonActionType = .current
            } else if UserDefaultsValues.availablFences.contains(where: {$0.rawValue == currentModel.rawValue}) {
                buttonActionType = .get
            } else if currentModel.purchaseIdentifier != nil /*let purchaseModel = presenter.checkIdentifier(model: currentModel)*/ {
                buttonActionType = .buyForMoney
            } else {
                buttonActionType = .buy
            }
        }
      //  buyButton.setTitle(currentModel.price.description, for: .normal)
    }
    
    @IBAction func buyButtonPressed(_ sender: Any) {
        switch buttonActionType {
        case .current:
            return
        case .get:
            if let currentModel = currentModel as? CannonModel {
                UserDefaultsValues.currentCannon = currentModel
            } else if let currentModel = currentModel as? CatapultModel {
                UserDefaultsValues.currentCatapult = currentModel
            } else if let currentModel = currentModel as? FenceModel {
                UserDefaultsValues.currentFence = currentModel
            }
        case .buy:
           showBuyAlert(currentModel: currentModel)
        case .buyForMoney:
            if let currentModel = currentModel {
                presenter.buyProduct(model: currentModel)
            }
        }
        if let currentModel = currentModel {
            configureShopButton(currentModel: currentModel)
        }
        
        
    }
//    @IBAction func segmentValueChanged(_ sender: Any) {
//
//    }
    
    @IBAction func restoreButtonTapped(_ sender: Any) {
        presenter.restorePurchases()
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        pressedButtonSound()
        router.back()
    }
}

extension ShopViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        pressedButtonSound()
        shopCollectionView.moveToFrame(contentOffset: 0)
        reloadData()
        if index == 3 {
            configureShopButton(currentModel: presenter.model[index].values.first!)
        }
    }
    
}

//
//  ShopPresenter.swift
//  Wildz
//
//  Created by Tanya Koldunova on 31.10.2022.
//

import Foundation
import UIKit

enum BuyButtonActionType {
    case current
    case get
    case buy
    case buyForMoney
    
    var buttonTitle: String {
        switch self {
        case .current:
            return "Current"
        case .get:
            return "Get"
        case .buy:
            return "Buy"
        case .buyForMoney:
            return "Buy"
        }
    }
}

protocol ShopViewProtocol: AnyObject {
    //var shopCollectionView: UICollectionView {get}
    func reloadData()
    func getSegmentIndex()->Int
    func configureShopButton(currentModel: ShopValuesModelProtocol)
    func getShopCollectionView()->UICollectionView
}

protocol ShopPresenterProtocol: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    init(view: ShopViewProtocol)
    
    func requestProduct()
    func checkIdentifier(model: ShopValuesModelProtocol)->ProductSub?
    func buyProduct(model: ShopValuesModelProtocol)
    func currentCell(scrollView: UIScrollView, collectionView: UICollectionView) -> UICollectionViewCell?
}

class ShopPresenter: NSObject, ShopPresenterProtocol {
    weak var view: ShopViewProtocol?
    var model = ShopModel.allCases
    let iapManager = IAPManager()
    var products: [ProductSub]?
    required init(view: ShopViewProtocol) {
        self.view = view
        super.init()
        self.requestProduct()
    }
    
    func requestProduct() {
        iapManager.requestProducts { products in
            self.products = products
            self.view?.configureShopButton(currentModel: self.model[0].values[0])
        }
    }
    
    func checkIdentifier(model: ShopValuesModelProtocol)->ProductSub? {
        return products?.first(where: {$0.subsctiption.rawValue == model.purchaseIdentifier})
    }
    
    func buyProduct(model: ShopValuesModelProtocol) {
        if let product = products?.first(where: {$0.subsctiption.rawValue == model.purchaseIdentifier}) {
            iapManager.buyProduct(product.product) { success, productId in
                if success {
                    if let model = model as? CannonModel {
                         UserDefaultsValues.availableCannons.append(model)
                    } else if let model = model as? CatapultModel {
                        UserDefaultsValues.availablCatapults.append(model)
                    } else if let model = model as? FenceModel {
                        UserDefaultsValues.availablFences.append(model)
                    }
                }
            }
        }
    }
    
     func currentCell(scrollView: UIScrollView, collectionView: UICollectionView) -> UICollectionViewCell? {
        guard var closestCell = collectionView.visibleCells.first else { return nil }
        for cell in collectionView.visibleCells as [UICollectionViewCell] {
            let closestCellDelta = abs(closestCell.center.x - collectionView.bounds.size.width/2.0 - collectionView.contentOffset.x)
            let cellDelta = abs(cell.center.x - collectionView.bounds.size.width/2.0 - collectionView.contentOffset.x)
            if (cellDelta < closestCellDelta) {
                closestCell = cell
            }
        }
        return closestCell
    }
}

extension ShopPresenter {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let index = view?.getSegmentIndex() ?? 0
        return model[index].values.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shop cell", for: indexPath) as! ShopCollectionViewCell
        let index = view?.getSegmentIndex() ?? 0
        let model = model[index].values[indexPath.row]
        let product = checkIdentifier(model: model)
        cell.configure(model: model, realMoney: product)
        return cell
    }
    
    func  collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 127)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let view = view else {return}
        if let cell = currentCell(scrollView: scrollView, collectionView: view.getShopCollectionView()), let currentCell = cell as? ShopCollectionViewCell {
            //view.currentModel = currentCell.model
            view.configureShopButton(currentModel: currentCell.model)
        }
    }
    
}

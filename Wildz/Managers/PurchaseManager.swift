//
//  PurchaseManager.swift
//  Wildz
//
//  Created by Tanya Koldunova on 04.11.2022.
//

import Foundation
import StoreKit

public typealias ProductsRequestCompletionHandler = (_ products: [ProductSub]?) -> Void
public typealias ProductPurchaseCompletionHandler = (_ success: Bool, _ productId : String?) -> Void

enum Subscription:String, CaseIterable {
    case bestCannon = "com.upgradedCannon.character"
    case bestCatapult = "com.upgradedCatapult.character"
    case bestFence = "com.upgradedFence.character"
}

class IAPManager: NSObject {
    private var productsRequestCompletionHandler: ProductsRequestCompletionHandler?
    private var productPurchaseCompletionHandler: ProductPurchaseCompletionHandler?
    private let productsID = Set([
        Subscription.bestCannon.rawValue,
        Subscription.bestCatapult.rawValue,
        Subscription.bestFence.rawValue,
       
    ])
    
    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    func requestProducts(_ complition: @escaping ProductsRequestCompletionHandler) {
        productsRequestCompletionHandler = complition
        let request = SKProductsRequest(productIdentifiers: productsID)
        request.delegate = self
        request.start()
    }
    
    func buyProduct(_ id: SKProduct, _ complition: @escaping ProductPurchaseCompletionHandler) {
        guard SKPaymentQueue.canMakePayments() else { return }
        productPurchaseCompletionHandler = complition
        let payment = SKPayment(product: id)
        SKPaymentQueue.default().add(payment)
        
    }
    
    func restoreTransactions(_ complition : @escaping ProductPurchaseCompletionHandler) {
            productPurchaseCompletionHandler = complition
            if (SKPaymentQueue.canMakePayments()) {
                SKPaymentQueue.default().restoreCompletedTransactions()
            }
        }
}

extension IAPManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        productsRequestCompletionHandler?(response.products.map { ProductSub($0)})
        clearRequestAndHandler()
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        if request is SKProductsRequest {
            print("Subscription Options Failed Loading: \(error.localizedDescription)")
        }
        productsRequestCompletionHandler?(nil )
        clearRequestAndHandler()
    }
    private func clearRequestAndHandler() {
        productsRequestCompletionHandler = nil
    }
    
}



extension IAPManager: SKPaymentTransactionObserver {
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                complete(transaction: transaction)
                break
            case .failed:
                fail(transaction: transaction)
                break
            case .restored:
//                SKPaymentQueue.default().finishTransaction(transaction)
                restore(transaction: transaction)
                break
            case .deferred:
                break
            case .purchasing:
                break
            }
        }
    }
    
    private func complete(transaction: SKPaymentTransaction) {
        print("complete...")
        productPurchaseCompleted(productID: transaction.payment.productIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func fail(transaction: SKPaymentTransaction) {
        print("fail...")
        if let transactionError = transaction.error as NSError?,
           let localizedDescription = transaction.error?.localizedDescription,
           transactionError.code != SKError.paymentCancelled.rawValue {
            print("Transaction Error: \(localizedDescription)")
        }
        
        productPurchaseCompletionHandler?(false, nil)
        SKPaymentQueue.default().finishTransaction(transaction)
        clearHandler()
    }
    
    private func restore(transaction: SKPaymentTransaction) {
            guard let productIdentifier = transaction.original?.payment.productIdentifier else { return }
            print("restore... \(productIdentifier)")
            productPurchaseCompleted(productID: productIdentifier)
            SKPaymentQueue.default().finishTransaction(transaction)
        }
     
    private func productPurchaseCompleted(productID : String) {
        productPurchaseCompletionHandler?(true, productID)
        clearHandler()
    }
    
    private func clearHandler() {
        productPurchaseCompletionHandler = nil
    }
    
}


//
//  ApplePayModel.swift
//  FonzMusicSwift
//
//  Created by didi on 11/19/21.
//

import Foundation
import Stripe
import PassKit
import SwiftUI

class ApplePayModel: NSObject, ObservableObject, STPApplePayContextDelegate {
    
    @Published var paymentStatus: STPPaymentStatus?
    @Published var lastPaymentError: Error?
    var clientSecret: String?
    
    func pay(clientSecret: String?, item: ItemFromShop) {
        self.clientSecret = clientSecret
        
        
        
        // config our apple pay payment req
        let pr = StripeAPI.paymentRequest(withMerchantIdentifier: "merchant.com.fonzmusic.fonz", country: "IE", currency: "eur")
        // billing contact
        pr.requiredBillingContactFields = [.emailAddress, .name, .postalAddress]
        // configure shipping methods (if multi option)
        pr.shippingMethods = []
        // add item to payment summary
        pr.paymentSummaryItems = [PKPaymentSummaryItem(label: item.info, amount: NSDecimalNumber(value: item.price))]
        var totalAmount: Double = Double(item.price)
        // if only 1 item, add shippung
        if item.quantity == 1 {
            pr.paymentSummaryItems.append(PKPaymentSummaryItem(label: "shipping", amount: 3))
            totalAmount += 3
        }
        // add summary of costs
        pr.paymentSummaryItems.append(PKPaymentSummaryItem(label: "Fonz Coasters", amount: NSDecimalNumber(value: totalAmount)))
        
        
        // present apple pay context
        let applePayContext = STPApplePayContext(paymentRequest: pr, delegate: self)
        applePayContext?.presentApplePay()
    }
    
    func applePayContext(_ context: STPApplePayContext, didCreatePaymentMethod paymentMethod: STPPaymentMethod, paymentInformation: PKPayment, completion: @escaping STPIntentClientSecretCompletionBlock) {
        // when payment method was created -> confirm our payment intent
        if (self.clientSecret != nil) {
            // call completion block w clientSecret
            completion(clientSecret, nil)
        }
        else {
            completion(nil, NSError())
        }
    }
    
    func applePayContext(_ context: STPApplePayContext, didCompleteWith status: STPPaymentStatus, error: Error?) {
        // get payment status or error
        self.paymentStatus = status
        self.lastPaymentError = error
    }
    
    
}

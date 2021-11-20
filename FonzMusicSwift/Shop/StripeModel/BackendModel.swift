//
//  BackendModel.swift
//  FonzMusicSwift
//
//  Created by didi on 11/19/21.
//

import Foundation
import Stripe

class BackendModel : ObservableObject {
    @Published var paymentStatus: STPPaymentHandlerActionStatus?
    @Published var paymentIntentParams: STPPaymentIntentParams?
    @Published var lastPaymentError: NSError?
    var paymentMethodType: String?
    var currency: String?

    func preparePaymentIntent(paymentMethodType: String, currency: String) {
        self.paymentMethodType = paymentMethodType
        self.currency = currency


    }
}

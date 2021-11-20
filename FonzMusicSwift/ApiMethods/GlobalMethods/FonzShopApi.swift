//
//  FonzShopApi.swift
//  FonzMusicSwift
//
//  Created by didi on 11/19/21.
//

import Foundation

struct FonzItemsAndPrices: Codable, Hashable {
    var coasters: Array<ItemFromShop>
}
struct CartIdResponse: Codable, Hashable {
    var cartId: String
}
struct PaymentIntentResponse: Codable, Hashable {
    var amount: Float
    var client_secret: String
    var id : String
}

class FonzShopApi {
    
    let ADDRESS = "https://fonzmusic.com/i/"
    let PRICES = "prices/"
    let CART = "cart/"
    let CHECKOUT = "checkout/"
    let PAYMENTINTENT = "payment-intent/"
    
    func getFonzItemsAndPrices(currency: String) -> [ItemFromShop] {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var items: [ItemFromShop] = [ItemFromShop]()

        // create url
        guard let url = URL(string: self.ADDRESS + "prices/" + currency ) else { return items}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // this is the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // code to defer until this is completed
            defer { sem.signal() }
            
            if let dataResp = data {
                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
                print(jsonData as Any)
                
                let returnCode = response?.getStatusCode() ?? 0
                print("returncode is \(returnCode)")
                if let decodedResponse = try? JSONDecoder().decode(FonzItemsAndPrices.self, from: dataResp) {
                    print("success getting items")
                    
                    items = decodedResponse.coasters
                    sem.resume()
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                        
//                    returnMessage = decodedResponse?.message ?? "error"
                    sem.resume()
                }
                
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
            sem.resume()
        }.resume()
        // tells function to wait before returning
        sem.wait()
        return items
    }
    
    func createFonzShopCart(packageId: String, currency: String) -> String {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var cartId: String = ""

        // create url
        guard let url = URL(string: self.ADDRESS + CART + packageId + "/" + currency ) else { return cartId}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // this is the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // code to defer until this is completed
            defer { sem.signal() }
            
            if let dataResp = data {
                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
//                print(jsonData as Any)
                
                let returnCode = response?.getStatusCode() ?? 0
                print("returncode is \(returnCode)")
                if let decodedResponse = try? JSONDecoder().decode(CartIdResponse.self, from: dataResp) {
                    print("success getting items")
                    
                    cartId = decodedResponse.cartId
                    sem.resume()
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                        
//                    returnMessage = decodedResponse?.message ?? "error"
                    sem.resume()
                }
                
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
            sem.resume()
        }.resume()
        // tells function to wait before returning
        sem.wait()
        return cartId
    }
    
    
    
    func createFonzShopPaymentIntent(cartId: String) -> PaymentIntentResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var paymentIntent: PaymentIntentResponse = PaymentIntentResponse(amount: 0, client_secret: "", id: "")
        print("cart id inside payment intent is \(cartId)")

        // create url
        guard let url = URL(string: self.ADDRESS + CHECKOUT + PAYMENTINTENT ) else { return paymentIntent}
        
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // init param
        let parameters = [
            "cartId": cartId,
        ] as [String : Any]
        // converts param dict to JSON DATA
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters)
        // adds JSON DATA to the body
        request.httpBody = jsonData
        // tells req that there is a body param
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // this is the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // code to defer until this is completed
            defer { sem.signal() }
            
            if let dataResp = data {
                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
                print(jsonData as Any)
                
                let returnCode = response?.getStatusCode() ?? 0
                print("returncode is \(returnCode)")
                if let decodedResponse = try? JSONDecoder().decode(PaymentIntentResponse.self, from: dataResp) {
                    print("success getting items")
                    
                    paymentIntent = decodedResponse
                    sem.resume()
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                        
//                    returnMessage = decodedResponse?.message ?? "error"
                    sem.resume()
                }
                
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
            sem.resume()
        }.resume()
        // tells function to wait before returning
        sem.wait()
        return paymentIntent
    }
}

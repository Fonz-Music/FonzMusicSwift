//
//  ProductViewModel.swift
//  Fonz Music App Clip
//
//  Created by didi on 2/13/21.
//

import Foundation
import Combine
import Firebase
//import FirebaseAuth
import Network

class CoastersFromApi: ObservableObject {
    

//    @Published private (set) var products: HostCoastersMapResult = HostCoastersMapResult(coasters: [
//            CoasterInfo(uid: "321fwedsadsa", hostName: "jeff", coasterName: "boston", sessionId: "adsdwqe2w").toHostCoasterResult(),
//            CoasterInfo(uid: "321fwedsadsa", hostName: "jeff", coasterName: "dublin", sessionId: "adsdwqe2w").toHostCoasterResult(),
//            CoasterInfo(uid: "321fwedsadsa", hostName: "jeff", coasterName: "limerick", sessionId: "adsdwqe2w", active: true).toHostCoasterResult(),
//            CoasterInfo(uid: "321fwedsadsa", hostName: "jeff", coasterName: "quincy", sessionId: "adsdwqe2w").toHostCoasterResult(),
//            CoasterInfo(uid: "321fwedsadsa", hostName: "jeff", coasterName: "trinity", sessionId: "adsdwqe2w").toHostCoasterResult(),
//            CoasterInfo(uid: "321fwedsadsa", hostName: "jeff", coasterName: "milton", sessionId: "adsdwqe2w").toHostCoasterResult()
//        ], quantity: 7)
    @Published private (set) var products: HostCoastersMapResult = HostCoastersMapResult(coasters: [], quantity: 0)
    

    
    
    
    // MARK:- Initiliazer for product via model.
    
    init() {
        products = HostCoastersApi().getOwnedCoasters()
//        if (products.quantity == 0 ) {
//            // sets app to NOT have coasters if the user lacks them
//            UserDefaults.standard.set(false, forKey: "hasConnectedCoasters")
//        }
        print("starting this owned coasters")

    }
    
    func reloadCoasters() {
        products = HostCoastersApi().getOwnedCoasters()
    }
    func determineIfHasCoasters() -> Bool {
        products = HostCoastersApi().getOwnedCoasters()
        print("quantity is  \(products)")
        if products.quantity > 0 {
            print("has coasters")
            return true
        }
        else {
            print("no coasters")
            return false
        }
    }
    
}

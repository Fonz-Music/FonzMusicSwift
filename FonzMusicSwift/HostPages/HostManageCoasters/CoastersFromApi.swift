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
    

//    @Published private (set) var products: [CoasterInfo] = [CoasterInfo(uid: "321fwedsadsa", hostName: "jeff", coasterName: "boston", sessionId: "adsdwqe2w"),CoasterInfo(uid: "321fwedsadsa", hostName: "jeff", coasterName: "dublin", sessionId: "adsdwqe2w"),CoasterInfo(uid: "321fwedsadsa", hostName: "jeff", coasterName: "limerick", sessionId: "adsdwqe2w", active: true),CoasterInfo(uid: "321fwedsadsa", hostName: "jeff", coasterName: "quincy", sessionId: "adsdwqe2w"),CoasterInfo(uid: "321fwedsadsa", hostName: "jeff", coasterName: "trinity", sessionId: "adsdwqe2w"),CoasterInfo(uid: "321fwedsadsa", hostName: "jeff", coasterName: "milton", sessionId: "adsdwqe2w"),]
    @Published private (set) var products: HostCoastersMapResult = HostCoastersMapResult(coasters: [], quantity: 0)
    
    
    // MARK:- Initiliazer for product via model.
    
    init() {
        products = HostCoasterApi().getOwnedCoasters()
        print("starting this")

    }
    
    func reloadCoasters() {
        products = HostCoasterApi().getOwnedCoasters()
    }
    
}

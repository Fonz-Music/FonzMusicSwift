//
//  CoreUserAttributes.swift
//  FonzMusicSwift
//
//  Created by didi on 7/31/21.
//

import Foundation

class CoreUserAttributes: ObservableObject {
    @Published private var hasAccount = UserDefaults.standard.bool(forKey: "hasAccount")
    @Published private var hasConnectedCoasters = UserDefaults.standard.bool(forKey: "hasConnectedCoasters")
    @Published private var connectedToSpotify = UserDefaults.standard.bool(forKey: "connectedToSpotify")
    
    func setHasAccount(bool : Bool) {
        hasAccount = bool
        UserDefaults.standard.set(bool, forKey: "hasAccount")
    }
    func getHasAccount() -> Bool {
        return hasAccount
    }
    
    func setHasConnectedCoasters(bool : Bool) {
        hasConnectedCoasters = bool
        UserDefaults.standard.set(bool, forKey: "hasConnectedCoasters")
    }
    func getHasConnectedCoasters() -> Bool {
        return hasConnectedCoasters
    }
    
    func setConnectedToSpotify(bool : Bool) {
        connectedToSpotify = bool
        UserDefaults.standard.set(bool, forKey: "connectedToSpotify")
    }
    func getConnectedToSpotify() -> Bool {
        return connectedToSpotify
    }
}

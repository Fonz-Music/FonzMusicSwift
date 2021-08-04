//
//  CoreUserAttributes.swift
//  FonzMusicSwift
//
//  Created by didi on 7/31/21.
//

import Foundation

class CoreUserAttributes: ObservableObject {
    // determines if current user has an account
    @Published private var hasAccount = UserDefaults.standard.bool(forKey: "hasAccount")
    // bool on if the user has coasters connected
    @Published private var hasConnectedCoasters = UserDefaults.standard.bool(forKey: "hasConnectedCoasters")
    // determines if current user is connected to Spotify
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
    
    func determineIfUserConnectedToSpotify() {
        let musicProviders = SpotifySignInApi().getMusicProviders()
        print("music provs \(musicProviders)")
        // checks how many providers & updates accordingly
        if (musicProviders.count > 0 && musicProviders[0].providerId != ""){
            setConnectedToSpotify(bool: true)
        }
        else {
            setConnectedToSpotify(bool: false)
        }
    }
    func determineIfUserHasConnectedCoasters() {
        let ownedCoasters = HostCoasterApi().getOwnedCoasters()
        print("music provs \(ownedCoasters)")
        // checks how many providers & updates accordingly
        if (ownedCoasters.quantity > 0 && ownedCoasters.coasters[0].coasterId != ""){
            setHasConnectedCoasters(bool: true)
        }
        else {
            setHasConnectedCoasters(bool: false)
        }
    }
}

//
//  CoreUserAttributes.swift
//  FonzMusicSwift
//
//  Created by didi on 7/31/21.
//

import KeychainAccess
import Foundation

class CoreUserAttributes: ObservableObject {
    // determines if current user has an account
    @Published private var hasAccount = UserDefaults.standard.bool(forKey: "hasAccount")
    // bool on if the user has coasters connected
    @Published private var hasConnectedCoasters = UserDefaults.standard.bool(forKey: "hasConnectedCoasters")
    // determines if current user is connected to Spotify
    @Published private var connectedToSpotify = UserDefaults.standard.bool(forKey: "connectedToSpotify")
    // determines if current user is connected to Spotify
    @Published private var agreedToEmail = UserDefaults.standard.bool(forKey: "agreedToEmail")
    // determines if current user is connected to Spotify
    @Published private var agreedConsent = UserDefaults.standard.bool(forKey: "agreedConsent")
    // determines if current user is connected to Spotify
    @Published private var userId = UserDefaults.standard.string(forKey: "userId")
    // determines if current user is connected to Spotify
    @Published private var userDisplayName = UserDefaults.standard.string(forKey: "userDisplayName")
    // determines if current user is connected to Spotify
    @Published private var userEmail = UserDefaults.standard.string(forKey: "userEmail")
    // determines if current user is connected to Spotify
    @Published private var userSessionId = UserDefaults.standard.string(forKey: "userSessionId")
    
    // gets all preferences
    func determineAllUserPrefrencesAfterSignIn() {
        determineIfUserConnectedToSpotify()
        if (getConnectedToSpotify()) {
            determineIfUserHasConnectedCoasters()
        }
        // set agreedToEmail
        agreedToEmail = UserDefaults.standard.bool(forKey: "agreedToEmail")
        // set userId
        userId = UserDefaults.standard.string(forKey: "userId")
        // set display name
        userDisplayName = UserDefaults.standard.string(forKey: "userDisplayName")
        // set user email
        userEmail = UserDefaults.standard.string(forKey: "userEmail")
        // set user sessionId
//        userEmail = UserDefaults.standard.string(forKey: "userEmail")
    }
    
    // gets all preferences
    func determineAllUserPrefrencesAfterFirstLaunch() {
        determineIfUserConnectedToSpotify()
        if (getConnectedToSpotify()) {
            determineIfUserHasConnectedCoasters()
        }
        // GET user 
        // set agreedToEmail
        agreedToEmail = UserDefaults.standard.bool(forKey: "agreedToEmail")
        // set userId
        userId = UserDefaults.standard.string(forKey: "userId")
        // set display name
        userDisplayName = UserDefaults.standard.string(forKey: "userDisplayName")
        // set user email
        userEmail = UserDefaults.standard.string(forKey: "userEmail")
        // set user sessionId
//        userEmail = UserDefaults.standard.string(forKey: "userEmail")
    }
    
    func deleteAllUserPrefrencesAfterSignOut() {
        setHasAccount(bool: false)
        setConnectedToSpotify(bool: false)
        setHasConnectedCoasters(bool: false)
        setAgreedToEmail(bool: false)
        setUserEmail(email: "")
        setUserDisplayName(name: "")
        setUserId(newUserId: "")
        setUserSessionId(newSessionId: "")
    }
    
// ------------------------------ has account -----------------------------------
    func setHasAccount(bool : Bool) {
        hasAccount = bool
        UserDefaults.standard.set(bool, forKey: "hasAccount")
    }
    func getHasAccount() -> Bool {
        return hasAccount
    }
    func determineIfUserHasAccount()  {
        // if the user has consented,
        // they've completed the form & will have an account
        if (getAgreedConsent()) {
            setHasAccount(bool: true)
        }
    }
    
// ----------------------------- has coasters -----------------------------------
    func setHasConnectedCoasters(bool : Bool) {
        hasConnectedCoasters = bool
        UserDefaults.standard.set(bool, forKey: "hasConnectedCoasters")
    }
    func getHasConnectedCoasters() -> Bool {
        return hasConnectedCoasters
    }
    func determineIfUserHasConnectedCoasters() {
        let ownedCoasters = HostCoastersApi().getOwnedCoasters()
        print("music provs \(ownedCoasters)")
        // checks how many providers & updates accordingly
        if (ownedCoasters.quantity > 0 && ownedCoasters.coasters[0].coasterId != ""){
            setHasConnectedCoasters(bool: true)
        }
        else {
            setHasConnectedCoasters(bool: false)
        }
    }
    
// ------------------------------ has Spotify -----------------------------------
    func setConnectedToSpotify(bool : Bool) {
        connectedToSpotify = bool
        UserDefaults.standard.set(bool, forKey: "connectedToSpotify")
    }
    func getConnectedToSpotify() -> Bool {
        return connectedToSpotify
    }
    
    func determineIfUserConnectedToSpotify() {
        let musicProviders = ProviderApi().getMusicProviders()
        print("music provs \(musicProviders)")
        // checks how many providers & updates accordingly
        if (musicProviders.count > 0 && musicProviders[0].providerId != ""){
            setConnectedToSpotify(bool: true)
        }
        else {
            setConnectedToSpotify(bool: false)
        }
    }
// -------------------------- agreed to email -----------------------------------
    func setAgreedToEmail(bool : Bool) {
        agreedToEmail = bool
        UserDefaults.standard.set(bool, forKey: "agreedToEmail")
    }
    func getAgreedToEmail() -> Bool {
        return agreedToEmail
    }
// -------------------------- agreed consent -----------------------------------
    func setAgreedConsent(bool : Bool) {
        agreedConsent = bool
        UserDefaults.standard.set(bool, forKey: "agreedConsent")
    }
    func getAgreedConsent() -> Bool {
        return agreedConsent
    }
// ------------------------------ user Id ---------------------------------------
    func setUserId(newUserId : String) {
        userId = newUserId
        UserDefaults.standard.set(newUserId, forKey: "userId")
    }
    func getUserId() -> String {
        return userId ?? ""
    }
// ------------------------- display name ---------------------------------------
    func setUserDisplayName(name : String) {
        userDisplayName = name
        UserDefaults.standard.set(name, forKey: "userDisplayName")
    }
    func getUserDisplayName() -> String {
        return userDisplayName ?? ""
    }
 
// --------------------------- user email ---------------------------------------
    func setUserEmail(email : String) {
        userEmail = email
        UserDefaults.standard.set(email, forKey: "userEmail")
    }
    func getUserEmail() -> String {
        return userEmail ?? ""
    }
// ----------------------- user sessionId ---------------------------------------
    func setUserSessionId(newSessionId : String) {
        userSessionId = newSessionId
        UserDefaults.standard.set(newSessionId, forKey: "userSessionId")
    }
    func getUserSessionId() -> String {
        return userSessionId ?? ""
    }
    func determineIfUserHasASession() {
        let sessions = SessionApi().getAllSessions()
        print("sessions are \(sessions)")
        // checks how many providers & updates accordingly
        if (sessions.count > 0 && sessions[0].sessionId != ""){
            setUserSessionId(newSessionId: sessions[0].sessionId)
        }
        else {
            setUserSessionId(newSessionId: "")
        }
    }
     
}

//
//  CheckJWTExpired.swift
//  FonzMusicSwift
//
//  Created by didi on 7/19/21.
//

import Foundation
import KeychainAccess

func getJWTAndCheckIfExpired() -> String {
    
    var isValid = false
    
    // fetch token from keystore
    // init keychain
    let keychainAccess = Keychain(service: "api.fonzmusic.com")
    // retrive accessToken
    var accessToken = keychainAccess["accessToken"]
    // check that its not empty
    if accessToken != nil && accessToken != "" {
        isValid = checkIfTokenValid(accessToken: accessToken!)
    }
    // check if its valid OR if the accessToken is nil
    if !isValid {
        print("token is not valid")
        // if its not valid, generate a new one & store it
        
        // gets password from keychain
            // gets password from keychain
            let keychainRefresh = Keychain(service: "api.fonzmusic.com")
            let refreshToken = keychainRefresh["refreshToken"]
        print("refresh is \(refreshToken)")
        
        // if the user already has an account (refresh token + access token (even if expired)
        if refreshToken != nil && refreshToken != "" && accessToken != nil && accessToken != "" {
            let userId = getUserIdFromAccessToken(accessToken: accessToken!)
            // gets new token by passing email + password into api
            accessToken = AuthApi().refreshAccessToken(userId: userId, refreshToken: refreshToken!).message
        }
        // otherwise create a new anon account
        else {
            accessToken = AuthApi().createAnonAccount().message
        }
    }
    print("token is \(accessToken)")
    return accessToken!
}

func checkIfTokenValid(accessToken : String) -> Bool {
    var isValid : Bool = false
    // convert token to base 64
        var payload64 = accessToken.components(separatedBy: ".")[1]
        // need to pad the string with = to make it divisible by 4,
        // otherwise Data won't be able to decode it
        while payload64.count % 4 != 0 {
            payload64 += "="
        }
        let payloadData = Data(base64Encoded: payload64,
                               options:.ignoreUnknownCharacters)!
        let payload = String(data: payloadData, encoding: .utf8)!
    // parse json to retreive exp
        let json = try! JSONSerialization.jsonObject(with: payloadData, options: []) as! [String:Any]
        let exp = json["exp"] as! Int
        let expDate = Date(timeIntervalSince1970: TimeInterval(exp))
        isValid = expDate.compare(Date()) == .orderedDescending
    
    return isValid
}




func getUserIdFromAccessToken(accessToken : String) -> String {
    var userId : String = ""
    // convert token to base 64
    var payload64 = accessToken.components(separatedBy: ".")[1]
        print("pay 64 \(payload64)")
    // need to pad the string with = to make it divisible by 4,
    // otherwise Data won't be able to decode it
    while payload64.count % 4 != 0 {
        payload64 += "="
    }
    let payloadData = Data(base64Encoded: payload64,
                           options:.ignoreUnknownCharacters)!
    let payload = String(data: payloadData, encoding: .utf8)!
// parse json to retreive exp
    let json = try! JSONSerialization.jsonObject(with: payloadData, options: []) as! [String:Any]
    userId = json["userId"] as! String
   
    return userId
}

func deleteAccessAndRefreshOnSignOut() {
    // resets both accessToken + refreshToken
    let keychain = Keychain(service: "api.fonzmusic.com")
    do {
        try keychain
            .label("fonzMusicApiRefreshToken")
            .set("", key: "refreshToken")
    } catch let error {
        print("error: \(error)")
    }
    // stores acess token
    do {
        try keychain
            .label("fonzMusicApiAcesssToken")
            .set("", key: "accessToken")
    } catch let error {
        print("error: \(error)")
    }
}

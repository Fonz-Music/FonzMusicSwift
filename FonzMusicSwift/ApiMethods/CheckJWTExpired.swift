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
    if accessToken != nil {
        print("token is not empty")
        // convert token to base 64
            var payload64 = accessToken!.components(separatedBy: ".")[1]
            // need to pad the string with = to make it divisible by 4,
            // otherwise Data won't be able to decode it
            while payload64.count % 4 != 0 {
                payload64 += "="
            }

            print("base64 encoded payload: \(payload64)")
            let payloadData = Data(base64Encoded: payload64,
                                   options:.ignoreUnknownCharacters)!
            let payload = String(data: payloadData, encoding: .utf8)!
            print(payload)
        // parse json to retreive exp
            let json = try! JSONSerialization.jsonObject(with: payloadData, options: []) as! [String:Any]
            let exp = json["exp"] as! Int
            let expDate = Date(timeIntervalSince1970: TimeInterval(exp))
            isValid = expDate.compare(Date()) == .orderedDescending
    }
    
    
    // check if its valid
    if !isValid {
        print("token is not valid")
        // if its not valid, generate a new one & store it
        
        // gets password from keychain
            // get email from user defaults
            let userEmail = UserDefaults.standard.string(forKey: "userEmail")
            // gets password from keychain
            let keychainPassword = Keychain(service: "api.fonzmusic.com")
            let password = keychainPassword[userEmail!]
        // gets new token by passing email + password into api
            accessToken = SignInSignUpApi().loginUser(email: userEmail!, password: password!).message

        // updates the keystore w the new accessToken
            do {
                try keychainAccess
                    .label("fonzMusicApiAcesssToken")
                    .set(accessToken!, key: "accessToken")
            } catch let error {
                print("error: \(error)")
            }
    }
    else {
        print("token is valid ")
    }
    
    
    // else,
    
    
    return accessToken!
    
    
}

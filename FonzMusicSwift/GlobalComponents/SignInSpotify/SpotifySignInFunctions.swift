//
//  SpotifyInBrowser.swift
//  FonzMusicSwift
//
//  Created by didi on 6/23/21.
//
import SwiftUI
import Foundation
import Firebase

struct SpotifySignInFunctions {
    
    @Environment(\.openURL) var openURL
    
    func launchSpotifyInBrowser() {
//        SessionApi().createSession()
        SessionApi().fetchSessionsAndCreateIfNone()
//
        let authorizeUrl = SpotifyAuthApi().getSpotifySignInUrl()
        print("url is \(authorizeUrl)")
        let url = URL(string: authorizeUrl)
//        let newUrl = URL(
//        print("url informed is \(url)")
        if authorizeUrl.count > 20 {
            openURL(url!)
        }
        
        print("launched spotify")
    }
    
    func addSpotifyToCurrentSession(sessionId : String) -> String {
        var returnString = ""
        var currentSessionId = sessionId
        if sessionId == nil || sessionId == "" {
            currentSessionId = SessionApi().createSession().message
        }
        let addToProviderResponse = SessionApi().addProviderToSession(sessionId: currentSessionId ?? "")
        
        if addToProviderResponse.status == 200 {
            returnString = "SPOTIFY_CONNECT_SUCCESS"
        }
        else {
            returnString = "SPOTIFY_CONNECT_FAILURE"
        }
        return returnString
    }

}

func fetchEmailFromSpotifyAdditional(additionalText : String) -> String {
    let textWithoutDash = additionalText.replacingOccurrences(of: "\\", with: "")
    print("texts w/o dash is \(textWithoutDash)")
    let compsFromAdditional = textWithoutDash.split(separator: ",")
//    print("texts w/o dash is \(textWithoutDash)")
    let emailComp = compsFromAdditional[3]
    print("email comp is \(emailComp)")
    let compsFromEmail = emailComp.split(separator: ":")
    let email = compsFromEmail[1]
    print("email is \(email)")
    return email.replacingOccurrences(of: "\"", with: "")
}

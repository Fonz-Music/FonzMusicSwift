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
        SessionApi().getAllSessionsAndCreateIfNone()

//        HostFonzSessionApi().getSession(sessionId: "e54e4af3-5a81-4512-885b-b5b670093303")
        
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

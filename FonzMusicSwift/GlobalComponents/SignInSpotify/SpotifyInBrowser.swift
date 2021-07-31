//
//  SpotifyInBrowser.swift
//  FonzMusicSwift
//
//  Created by didi on 6/23/21.
//
import SwiftUI
import Foundation
import Firebase

struct SpotifyInBrowser {
    
    @Environment(\.openURL) var openURL
    
    func launchSpotifyInBrowser() {
        HostFonzSessionApi().getAllSessions()

//        HostFonzSessionApi().getSession(sessionId: "e54e4af3-5a81-4512-885b-b5b670093303")
        
        let authorizeUrl = SpotifySignInApi().getSpotifySignInUrl()
        print("url is \(authorizeUrl)")
        let url = URL(string: authorizeUrl)
//        let newUrl = URL(
//        print("url informed is \(url)")
        if authorizeUrl.count > 20 {
            openURL(url!)
        }
        
        print("launched spotify")
    }

}

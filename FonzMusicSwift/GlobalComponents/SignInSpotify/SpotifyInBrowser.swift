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
        
        let authorizeUrl = SpotifySignInApi().getSpotifySignInUrl()
        print("url is \(authorizeUrl)")
        let url = URL(string: authorizeUrl)
        if authorizeUrl.count > 20 {
            openURL(url!)
        }
        
        print("launched spotify")
    }

}

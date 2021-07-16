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
        
        
        
        guard let user = Auth.auth().currentUser else {
            print("there was an error getting the user")
            return
        }
        user.getIDToken(){ (idToken, error) in
            if error == nil, let token = idToken {
                let userToken = token

                guard let url = URL(string: "https://api.fonzmusic.com/auth/spotify?token=\(userToken)") else {
                    return
                }
                openURL(url)
                print("launched spotify")
            }
        }
    }

}

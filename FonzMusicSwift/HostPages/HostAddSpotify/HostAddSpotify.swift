//
//  HostAddCoaster.swift
//  FonzMusicSwift
//
//  Created by didi on 4/27/21.
//

import SwiftUI

struct HostAddSpotify: View {

    // scaled height of icon
    let imageHeight = UIScreen.screenHeight * 0.15
    
        @StateObject var spotifyController = SpotifyController()
    
    var body: some View {
        
        
       
        ZStack {
            Color.amber.ignoresSafeArea()
            VStack{
                Spacer()
                Text("you haven't linked your Spotify yet").fonzSubheading().padding(.top, 130)
                Image("spotifyIcon").resizable()
                    .frame(width: imageHeight * 0.8, height: imageHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                            .padding(.top, 130)
                Spacer()
                Button(action: {
                    let sessionManager = spotifyController.sessionManager
                    if #available(iOS 11, *) {
                        spotifyController.fetchSpotifyCode(completion: { (dictionary, error) in
                            if let error = error {
                                print("Fetching token request error \(error)")
                                return
                            }
                            else {
                                print("got something")
                            }
//                            let accessToken = dictionary!["access_token"] as! String
//                            DispatchQueue.main.async {
//                                self.appRemote.connectionParameters.accessToken = accessToken
//                                self.appRemote.connect()
//                            }
                        })
                          // Use this on iOS 11 and above to take advantage of SFAuthenticationSession
//                        sessionManager!.initiateSession(with: spotifyController.scopes, options: .default)
//                        print("session is \(sessionManager?.session)" )
                        } else {
                          // Use this on iOS versions < 11 to use SFSafariViewController
//                            sessionManager.initiateSession(with: spotifyController.scopes, options: .clientOnly, presenting: self)
                        }
                    
                    print("pressed button")
                }, label: {
                    Text("add your Spotify").fonzSubheading()
                })
                .buttonStyle(NeumorphicButtonStyle(bgColor: .amber))
                .padding(.top, 100)
                .padding(.bottom, 50)
                Spacer()
            }
            }
        
    }
    
    
    
    
}

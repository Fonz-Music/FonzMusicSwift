//
//  HostAddCoaster.swift
//  FonzMusicSwift
//
//  Created by didi on 4/27/21.
//

import SwiftUI

struct HostAddSpotify: View {
// ---------------------------------- inherited from parent -----------------------------------------
    // gets object to determine if the page should be updated
    @Binding var determineHostViewUpdate: UpdatePageViewVariables
    // app rebuilds on other pages
    @Binding var hostPageNumber:Int
    
    @ObservedObject var hostCoasterList: CoastersFromApi
// ---------------------------------- created in view -----------------------------------------------
    // bool auto set to false, set to true if spotify is launched
    @State var launchedSpotify = false
    // local var that is returned by nfc prompt when getting host from API
    @State var statusCodeResp = 0
    
    @State var launchRenameModal = false
    // scaled height of icon
    let imageHeight = UIScreen.screenHeight * 0.15
    
    var body: some View {
        
        if launchedSpotify {
       
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
//                            pressedButtonToLaunchNfc = true
                            // launch spotify sign in
//                            LaunchSpotifyWebview(controller: UIViewController)
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
            // if user has launched the nfc tap
            else {
                
                // if the guest connects to their host properly
                if statusCodeResp == 200 {
                    SuccessAddedCoaster().onAppear {
                        // waits 3.5 seconds before naviagiting to dashboard
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            print("firing now")
                            launchRenameModal = true
//                            launchedNfc = false
                            
                            // will launch popup to name coaster
                        }
                    }
                }
                // if theres an issue connecting
                else {
                    ZStack {
                        Color.amber.ignoresSafeArea()
                        VStack{
                            Spacer()
                            
                            // if its not in our db
                            if (statusCodeResp == 404 ) {
                                ErrorNotFonzCoaster().padding(.top, 40)
                            }
                            //
                            
                            // any other error (usually nfc didnt work)
                            else {
                                ErrorOnTap().padding(.top, 40)
                            }
                            Spacer()
                            // button to launch nfc again
                            Button(action: {
//                                pressedButtonToLaunchNfc = true
                                print("pressed button")
                            }, label: {
                                Text("connect again").fonzSubheading()
                            }).buttonStyle(NeumorphicButtonStyle(bgColor: .amber)).padding(.vertical, 100)
                            
//                            Spacer()
                        }
                    }
                }
            }
    }
}

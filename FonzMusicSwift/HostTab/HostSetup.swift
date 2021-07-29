//
//  HostSetup.swift
//  FonzMusicSwift
//
//  Created by didi on 6/16/21.
//

import SwiftUI
//import Firebase
import FirebaseAnalytics


struct HostSetup: View {
    
    
    @Binding var connectedToSpotify : Bool
    
    @Binding var hasConnectedCoasters : Bool
    // determines if current user has an account
    @Binding var hasAccount : Bool
    // list of coasters connected to the Host
    @ObservedObject var coastersConnectedToHost: CoastersFromApi
    
// ---------------------------------- created in view -----------------------------------------------
    // bool auto set to false, set to true if nfc is launched
    @State var launchedNfc = false
    // temp Coaster Object so that page does not update BEFORE showing success page
    @State var tempCoasterDetails = HostCoasterInfo()
    // local var that is returned by nfc prompt when getting host from API
    @State var statusCodeResp = 0
    
    @State var pressedButtonToLaunchNfc = false
    
    @State var showSuccessOrError = false
    
    @State var throwCreateAccountModal = false
    
    @Environment(\.colorScheme) var colorScheme
    let tapCoasterWidth = UIScreen.screenHeight * 0.35
    
    var body: some View {
        
//        NameYourCoasterView(hasConnectedCoasters: $hasConnectedCoasters, coasterUid: tempCoasterDetails.uid)
//            .padding(.top, 100)
////            .isHidden(!showSuccessOrError)
//            .onAppear {
//
//            }
        
        VStack {

            // if the user has not tried to connect their first coaster
            if (!launchedNfc) {
                // if the nfc is NOT actice
                if (!pressedButtonToLaunchNfc) {
                    // if the user has NOT connected to spotify
//                    if (!connectedToSpotify) {
                        VStack {
                                Spacer()
                                    .frame(height: 30)
//                            }
                            ConnectSpotifyButtonHomeView(connectedToSpotify: $connectedToSpotify, hasAccount: $hasAccount, throwCreateAccountModal: $throwCreateAccountModal)
                                .addOpacity(connectedToSpotify)
                                .disabled(connectedToSpotify)
                                
                                .animation(.easeInOut(duration: 2.0))
                                .scaleEffect(connectedToSpotify ? 0.7 : 1.2)
                            if connectedToSpotify {
                                Spacer()
                            }
                            else {
                                Spacer()
                                    .frame(minHeight: 50, maxHeight: 80)
                            }
                           
                                
                            ConnectYourFirstCoasterButton(pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc, connectedToSpotify: $connectedToSpotify)
                                .addOpacity(!connectedToSpotify)
        //                        .animation(.easeInOut(duration: 4))
                                .animation(.easeInOut(duration: 2.0))
                                .scaleEffect(!connectedToSpotify ? 0.7 : 1.2)
                            Spacer()
                                .frame(minHeight: 70)
                        }
                        .sheet(isPresented: $throwCreateAccountModal) {
                            CreateAccountPrompt(hasAccount: $hasAccount, showModal: $throwCreateAccountModal)
                        }
                        
//                    }
//                    else {
//                        Spacer()
//                            .frame(height: UIScreen.screenHeight * 0.2)
//                    }
                    // connect first coaster button
                    
                   
                }
                // if the nfc IS active, show animation
                else {
                    VStack {
                        Spacer()
                            .frame(height: 50)
                        Text("tap your phone to the Fonz")
                            .foregroundColor(.lilac)
                            .fonzParagraphOne()
                        Image("tapCoasterIconLilac").resizable().frame(width: tapCoasterWidth, height: tapCoasterWidth * 0.75, alignment: .center)
                    }
                }
                Spacer()
                // launches NFC when the user pressed button
                if pressedButtonToLaunchNfc {
                    LaunchConnectCoasterNfc(tempCoaster: $tempCoasterDetails, launchedNfc: $launchedNfc, statusCode: $statusCodeResp, pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc).frame(maxWidth: 0, maxHeight: 0, alignment: .center)
                }
            }
            // aftermath of attempting to connect their first coaster
            else {
                Spacer()
                    .frame(height: 100)
                // if host joins their first coaster propeerly, prompt name
                if statusCodeResp == 204 {
                    VStack {
                        
                        // name coaster
                        NameYourCoasterView(hasConnectedCoasters: $hasConnectedCoasters, coastersConnectedToHost: coastersConnectedToHost, coasterUid: tempCoasterDetails.uid)
                            .onAppear {
                                

                            }
                        Spacer()
                    }
                }
                else {
                    ZStack {
                        // coaster belongs to someone else
                        if statusCodeResp == 200 {
                            SomeoneElsesCoaster(coasterName: tempCoasterDetails.coasterName, hostName: tempCoasterDetails.hostName)
                            // this is someone else's coaster
//                            Text("this coaster belongs to \(tempCoasterDetails.hostName) & is named \(tempCoasterDetails.coasterName)")
                        }
                        // coaster belongs to you (should not appear)
                        else if statusCodeResp == 403 {
                            ThisIsYourCoaster(coasterName: tempCoasterDetails.coasterName)
                            // this is someone else's coaster
                           
                        }
                        else {
                            FailCircleResponse(errorMessage: "you did not connect to the coaster :/")
                                .animation(.easeInOut(duration: 2))
                                .onAppear {
                                    FirebaseAnalytics.Analytics.logEvent("userConnectFirstCoasterFail", parameters: ["user":"user"])
                                }
                            if pressedButtonToLaunchNfc {
                                LaunchConnectCoasterNfc(tempCoaster: $tempCoasterDetails, launchedNfc: $launchedNfc, statusCode: $statusCodeResp, pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc).frame(maxWidth: 0, maxHeight: 0, alignment: .center)
                            }
                        }
                    }
//                    .padding(.top, 100)
                    .isHidden(!showSuccessOrError)
                    .onAppear {
                        // shows success or error view
                        withAnimation {
                            showSuccessOrError = true
                            pressedButtonToLaunchNfc = false
                        }
                        // after 7 seconds, resets home page to normal if connection fails
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                            withAnimation {
                                if !pressedButtonToLaunchNfc {
                                    launchedNfc = false
                                }

                            }
                        }
                    }
                    Spacer()
                }

            }
        }
    }
}




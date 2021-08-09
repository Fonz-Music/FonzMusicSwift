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
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    // list of coasters connected to the Host
    @ObservedObject var coastersConnectedToHost: CoastersFromApi
    
// ---------------------------------- created in view -----------------------------------------------
    // bool auto set to false, set to true if nfc is launched
    @State var launchedNfc = false
    // temp Coaster Object so that page does not update BEFORE showing success page
    @State var tempCoasterDetails = HostCoasterInfo()
    // local var that is returned by nfc prompt when getting host from API
    @State var statusCodeResp = 0
    // when user presses connectFirstCoaster -> nfc launches
    @State var pressedButtonToLaunchNfc = false
    // used to gradually fade in resp
    @State var showSuccessOrError = false

    // if the coaster needs to be encoded
    @State var encodeTheCoaster = false
    
    // if the coaster needs to be encoded
    @State var timesCheckedForCoasters = 0
    
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
                            ConnectSpotifyButtonHomeView(userAttributes: userAttributes)
                                .addOpacity(userAttributes.getConnectedToSpotify())
                                .disabled(userAttributes.getConnectedToSpotify())
                                
                                .animation(.easeInOut(duration: 2.0))
                                .scaleEffect(userAttributes.getConnectedToSpotify() ? 0.5 : 1.2)
                            if userAttributes.getConnectedToSpotify() {
                                Spacer()
                                    .frame(minHeight: 15, maxHeight: 80)
                            }
                            else {
                                Spacer()
                                    .frame(minHeight: 50, maxHeight: 80)
                            }
                           
                                
                            ConnectYourFirstCoasterButton(pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc, userAttributes: userAttributes)
                                .addOpacity(!userAttributes.getConnectedToSpotify())
        //                        .animation(.easeInOut(duration: 4))
                                .animation(.easeInOut(duration: 2.0))
                                .scaleEffect(!userAttributes.getConnectedToSpotify() ? 0.5 : 1.2)
                            Spacer()
                                .frame(minHeight: 70)
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
                    .frame(height: 20)
                // if host joins their first coaster propeerly, prompt name
                if statusCodeResp == 204 {
                    
                    // if coaster NOT encoded {
                    OneMoreStep()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                                encodeTheCoaster = true
                            }
                        }
                    if encodeTheCoaster {
                        EncodeCoasterWithUrl(tempCoasterUid: tempCoasterDetails.uid, statusCode: $statusCodeResp,pressedButtonToLaunchNfc: $encodeTheCoaster)
                    }
                    
                    // }
                    // else (coaster already encoded
                    
//                    VStack {
//
//                        // name coaster
//                        NameYourCoasterView(hasConnectedCoasters: $hasConnectedCoasters, coastersConnectedToHost: coastersConnectedToHost, coasterUid: tempCoasterDetails.uid)
//                            .onAppear {
//
//
//                            }
//                        Spacer()
//                    }
                    //}
                    
                }
                else if statusCodeResp == 602 {
                    VStack {
//                        Spacer()
//                            .frame(height: 50)
                        // name coaster
                        NameYourCoasterView(userAttributes: userAttributes, coastersConnectedToHost: coastersConnectedToHost, coasterUid: tempCoasterDetails.uid)
                        Spacer()
                    }
                }
                else {
                    ZStack {
                        // coaster belongs to someone else
                        if statusCodeResp == 403 {
//                            Spacer()
//                                .frame(height: 50)
                            SomeoneElsesCoaster(coasterName: tempCoasterDetails.coasterName, hostName: tempCoasterDetails.hostName)
                            // this is someone else's coaster
//                            Text("this coaster belongs to \(tempCoasterDetails.hostName) & is named \(tempCoasterDetails.coasterName)")
                        }
                        // coaster belongs to you (should not appear)
                        else if statusCodeResp == 200 {
//                            Spacer()
//                                .frame(height: 50)
                            ThisIsYourCoaster(coasterName: tempCoasterDetails.coasterName)
                                .onAppear{
                                    withAnimation {
                                        userAttributes.setHasConnectedCoasters(bool: true)
//                                        hasConnectedCoasters = true
                                    }
                                    
                                }
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
        .onAppear {
            if userAttributes.getHasAccount() {
                if timesCheckedForCoasters == 0 {
                    coastersConnectedToHost.reloadCoasters()
                    // updates coasters connected to host
                    userAttributes.setHasConnectedCoasters(bool: coastersConnectedToHost.determineIfHasCoasters())
                }
                
            }
        }
    }
}




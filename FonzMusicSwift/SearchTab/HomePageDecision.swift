//
//  HomePageDecision.swift
//  FonzMusicSwift
//
//  Created by didi on 6/15/21.
//

import SwiftUI
//import Firebase
import FirebaseAnalytics

struct HomePageDecision: View {
// ---------------------------------- inherited from parent -----------------------------------------
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    // inherited from parent and tells you if you have a host
    @Binding var hasHostVar:Bool
    // inherited that indicated the tab the app is on
    @Binding var selectedTab: TabIdentifier
    // determines if current user has an account
    @Binding var hasAccount : Bool
    // determines if current user has connectedCoasters
    @Binding var hasConnectedCoasters : Bool
// ---------------------------------- created in view -----------------------------------------------
    // bool auto set to false, set to true if nfc is launched
    @State var launchedNfc = false
    // temp Coaster Object so that page does not update BEFORE showing success page
    @State var tempCoasterDetails = HostCoasterInfo()
    // local var that is returned by nfc prompt when getting host from API
    @State var statusCodeResp = 0
    
    @State var pressedButtonToLaunchNfc = false
    
    
    
    @State var showHomeButtons = true
    
//    @State var throwCreateAccountModal = false
    
    @State var showSuccessOrError = false
    
    @State var errorMessage : String = ""
    
    
    @Environment(\.colorScheme) var colorScheme
    
  
    
    var body: some View {
        
            VStack{
                HStack{
                    Text("search")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white).fonzParagraphOne()
                        .padding(25)
                        .padding(.top, 40)
//                        .padding(.bottom, 20)
                    Spacer()
                }
                    
                
                if !launchedNfc {
                    
                    if showHomeButtons {
                        
                        DetermineHomePageView(selectedTab: $selectedTab, hasAccount: $hasAccount, showHomeButtons: $showHomeButtons, pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc, hasConnectedCoasters: $hasConnectedCoasters)
                        
                    }
                    else if !showHomeButtons && pressedButtonToLaunchNfc {
                        TapYourPhoneAmber()
                    }
                    if pressedButtonToLaunchNfc {
                        LaunchJoinPartyNfcSession(
                            tempCoaster: $tempCoasterDetails,
                            launchedNfc: $launchedNfc,
                            statusCode: $statusCodeResp,
                            pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc
                        ).frame(maxWidth: 0, maxHeight: 0, alignment: .center)
                    }
                }
                else {
//                    JoinPartyResponses(hostCoaster: hostCoaster,
//                        launchedNfc: $launchedNfc,
//                        tempCoasterDetails: $tempCoasterDetails,
//                        showHomeButtons: $showHomeButtons,
//                        statusCodeResp: statusCodeResp,
//                        pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc,
//                        hasHostVar: hasHostVar
//
//                    )
                    ZStack {
                        // if guest joins properly
                        if statusCodeResp == 200 {
                            JoinSuccessfulCircle(hostName: tempCoasterDetails.hostName, coasterName: tempCoasterDetails.coasterName)
                                .onAppear {
                                    // waits 3.5 seconds before naviagiting to searchbar
                                    FirebaseAnalytics.Analytics.logEvent("guestJoinPartySuccess", parameters: ["user":"guest"])
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                                        print("firing now")
                                        withAnimation {
                                        // changes hostCoaster details to return to parent
                                        self.hostCoaster.coasterName = tempCoasterDetails.coasterName
                                        self.hostCoaster.hostName = tempCoasterDetails.hostName
                                        self.hostCoaster.sessionId = tempCoasterDetails.sessionId
                                        self.hostCoaster.uid = tempCoasterDetails.uid
                                            
                                        self.hasHostVar = true
                                        }
                                    }
                                }
                        }
                        else if (statusCodeResp == 204) {
                            CoasterDoesNotHaveHost(selectedTab: $selectedTab, hasAccount: $hasAccount, showHomeButtons: $showHomeButtons, launchedNfc: $launchedNfc)
                        }
                        else {
                            

                            
                            FailCircleResponse(errorMessage: errorMessage)
                                .animation(.easeInOut)
                                .onAppear {
                                    if (statusCodeResp == 404) {
                                        errorMessage = "your host needs to connect their account to Spotify."
                                    }
                                    else if (statusCodeResp == 0) {
                                        errorMessage = "the nfc or wifi didn't properly work :/"
                                    }
                                    else if (statusCodeResp == 500) {
                                        errorMessage = "something is broken at Fonz HQ :/"
                                    }
                                
                                    FirebaseAnalytics.Analytics.logEvent("guestJoinPartyFail", parameters: ["user":"guest"])
                                   
                                    // after 7 seconds, resets home page to normal if connection fails
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                        withAnimation {
                                            if !pressedButtonToLaunchNfc {
                                                launchedNfc = false
                                                showHomeButtons = true
                                            }
                                            
                                        }
                                    }
                                }
                        }
                    }
                    .padding(.top, 100)
                    .isHidden(!showSuccessOrError)
                    .onAppear {
                        // shows success or error view
                        withAnimation {
                            showSuccessOrError = true
                            pressedButtonToLaunchNfc = false
                        }
                    }
                }
                
                Spacer()
            }
    }
}

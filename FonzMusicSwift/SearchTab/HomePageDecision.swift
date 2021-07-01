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
    
    @State var showSuccessOrError = false
    
    @State var showHomeButtons = true
    
//    @State var throwCreateAccountModal = false
    
    
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
                        else {
                            FailCircleResponse(errorMessage: "you did not join the party :/", errorImage: "signOutIcon")
                                .animation(.easeInOut(duration: 2))
                                .onAppear {
                                    FirebaseAnalytics.Analytics.logEvent("guestJoinPartyFail", parameters: ["user":"guest"])
                                   
                                    // after 7 seconds, resets home page to normal if connection fails
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
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

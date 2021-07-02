//
//  JoinPartyResponses.swift
//  FonzMusicSwift
//
//  Created by didi on 7/1/21.
//

import SwiftUI
import FirebaseAnalytics

struct JoinPartyResponses: View {
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    
    // bool auto set to false, set to true if nfc is launched
    @Binding var launchedNfc : Bool
    // temp Coaster Object so that page does not update BEFORE showing success page
    @Binding var tempCoasterDetails : HostCoasterInfo
    
    @Binding var showHomeButtons : Bool
    
    var statusCodeResp : Int
    @Binding var pressedButtonToLaunchNfc : Bool
    @Binding var hasHostVar : Bool
    
    @State var showSuccessOrError = false
    
    var body: some View {
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
//                CoasterDoesNotHaveHost()
            }
            else {
                FailCircleResponse(errorMessage: "you did not join the party :/")
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
}

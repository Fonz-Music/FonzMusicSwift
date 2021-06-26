//
//  HomePageDecision.swift
//  FonzMusicSwift
//
//  Created by didi on 6/15/21.
//

import SwiftUI

struct HomePageDecision: View {
// ---------------------------------- inherited from parent -----------------------------------------
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    // inherited from parent and tells you if you have a host
    @Binding var hasHostVar:Bool
    // inherited that indicated the tab the app is on
    @Binding var selectedTab: TabIdentifier
// ---------------------------------- created in view -----------------------------------------------
    // bool auto set to false, set to true if nfc is launched
    @State var launchedNfc = false
    // temp Coaster Object so that page does not update BEFORE showing success page
    @State var tempCoasterDetails = HostCoasterInfo()
    // local var that is returned by nfc prompt when getting host from API
    @State var statusCodeResp = 0
    
    @State var pressedButtonToLaunchNfc = false
    
    @State var showSuccessOrError = false
    
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    let tapCoasterWidth = UIScreen.screenHeight * 0.35
    
    @State var showHomeButtons = true
    @State var joinPartySuccess = false
    
    var body: some View {
        
        ZStack{
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
                        Spacer()
                            .frame(height: 100)
                        HostAPartyButton(selectedTab: $selectedTab, showHomeButtons: $showHomeButtons)
                        Spacer()
                            .frame(height: 100)
                        JoinAPartyButton(pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc, showHomeButtons: $showHomeButtons)
                    }
                    else if !showHomeButtons && pressedButtonToLaunchNfc {
                        VStack {
                            Spacer()
                                .frame(height: 50)
                            Text("tap your phone to the Fonz")
                                .foregroundColor(.amber)
                                .fonzParagraphOne()
                            Image("tapCoasterIconAmber").resizable().frame(width: tapCoasterWidth, height: tapCoasterWidth * 0.75, alignment: .center)
                        }
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
                            FailPartyJoin(pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc, errorMessage: "you did not join the party. press to try again", errorImage: "disableIcon")
                                .animation(.easeInOut(duration: 2))
//                            Button {
//                                withAnimation{
//                                    pressedButtonToLaunchNfc = true
//                                }
//
//                            } label: {
//                                FailPartyJoin(errorMessage: "you did not join the party. press to try again", errorImage: "disableIcon")
//                                    .animation(.easeInOut(duration: 2))
//                            }
                            if pressedButtonToLaunchNfc {
                                LaunchJoinPartyNfcSession(
                                    tempCoaster: $tempCoasterDetails,
                                    launchedNfc: $launchedNfc,
                                    statusCode: $statusCodeResp,
                                    pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc
                                ).frame(maxWidth: 0, maxHeight: 0, alignment: .center)
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
                Spacer()
            }
        }
    }
}

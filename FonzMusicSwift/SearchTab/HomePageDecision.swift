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
    // determines if current user is connected to spotify
    @Binding var connectedToSpotify : Bool
    // determines if current user is connected to spotify
    @Binding var hasHost : Bool
// ---------------------------------- created in view -----------------------------------------------
    // bool auto set to false, set to true if nfc is launched
    @State var launchedNfc = false
    // temp Coaster Object so that page does not update BEFORE showing success page
    @State var tempCoasterDetails = HostCoasterInfo()
    // local var that is returned by nfc prompt when getting host from API
    @State var statusCodeResp = 0
    // launches nfc when set to true
    @State var pressedButtonToLaunchNfc = false
    // bool to have home buttons disappear when nfc + resps are launched
    @State var showHomeButtons = true
    // bool to show the resp views after nfc finishes
    @State var showSuccessOrError = false
    // var to pass in error message
    @State var errorMessage : String = ""
    
    
    @Environment(\.colorScheme) var colorScheme
    
  
    
    var body: some View {
        
            VStack{
                HStack{
                    Text("queue")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white).fonzParagraphOne()
                        .padding(.headingFrontIndent)
                        .padding(.top, .headingTopIndent)
//                        .padding(.bottom, 20)
                    Spacer()
                }
                    
                // if the user has NOT finished w nfc nfc (defeault)
                if !launchedNfc {
                    // if home buttons should be shown, depends on nfc
                    if showHomeButtons {
                        DetermineHomePageView(selectedTab: $selectedTab, hasAccount: $hasAccount, showHomeButtons: $showHomeButtons, pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc, hasConnectedCoasters: $hasConnectedCoasters, connectedToSpotify: $connectedToSpotify)
                    }
                    // tap phone animation
                    else if !showHomeButtons && pressedButtonToLaunchNfc {
                        TapYourPhoneAmber()
                    }
                    // launhes nfc when bool changes
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
                                            UserDefaults.standard.set(tempCoasterDetails.sessionId, forKey: "hostSessionId")
                                        self.hostCoaster.coasterName = tempCoasterDetails.coasterName
                                        self.hostCoaster.hostName = tempCoasterDetails.hostName
                                        self.hostCoaster.sessionId = tempCoasterDetails.sessionId
                                        self.hostCoaster.uid = tempCoasterDetails.uid
                                            
                                        self.hasHostVar = true
                                        }
                                    }
                                }
                        }
                        // if the coaster lasts a host, give opp to become that host
                        else if (statusCodeResp == 204) {
                            CoasterDoesNotHaveHost(selectedTab: $selectedTab, hasAccount: $hasAccount, showHomeButtons: $showHomeButtons, launchedNfc: $launchedNfc)
                        }
                        // errors
                        else {
                            // display error prompt
                            FailCircleResponse(errorMessage: errorMessage)
                                .animation(.easeInOut)
                                .onAppear {
                                    // sets error message
                                    if (statusCodeResp == 404) {
                                        errorMessage = "what have you found?\nthis isn't a Fonz coaster :/"
                                    }
                                    else if (statusCodeResp == 403) {
                                        errorMessage = "your host needs to connect their account to Spotify."
                                    }
                                    else if (statusCodeResp == 0) {
                                        errorMessage = "the nfc or wifi didn't work properly :/"
                                    }
                                    else if (statusCodeResp == 500) {
                                        errorMessage = "something is broken at Fonz HQ :/"
                                    }
                                    else {
                                        errorMessage = "you've broken us."
                                    }
                                
                                    FirebaseAnalytics.Analytics.logEvent("guestJoinPartyFail", parameters: ["user":"guest"])
                                   
                                    // after 3 seconds, resets home page to normal if connection fails
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
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
            .onContinueUserActivity(NSUserActivityTypeBrowsingWeb, perform:
                    handleUserActivityReadingUid
            )
    }
    
    // this checks the launch url & if it includes a coasterUid, navigates to the searchbar or has the user connect to the coaster
    func handleUserActivityReadingUid(_ userActivity: NSUserActivity) {

        // sets the url if there is one
        guard let incomingUrl = userActivity.webpageURL
              else {
            return
        }
        // divides it & makes potentional uid = lastSection
        let dividedUrl = incomingUrl.absoluteString.split(separator: "/")
        let lastSection = dividedUrl[dividedUrl.count - 1]
        
        print(lastSection)
        // each uid is exactly 14 chars
        if (lastSection.count == 14) {
            print("uid is \(String(lastSection))")

            let coasterDetails = GuestApi().getCoasterInfo(coasterUid: String(lastSection))
            
            DispatchQueue.main.async {
                // if the uid is valid
                if (coasterDetails.statusCode == 200 || coasterDetails.statusCode == 204) {

                    // sets all params
                    self.hostCoaster.coasterName = coasterDetails.coasterName
                    self.hostCoaster.hostName = coasterDetails.displayName
                    self.hostCoaster.sessionId = coasterDetails.sessionId
                    self.hostCoaster.uid = String(lastSection)
                    // if it has a host, nav to search
                    if (coasterDetails.statusCode == 200) {
                        self.hasHost = true
                    }
                    // otherwise have user connect to it as a host
                    else {
                        launchedNfc = true
                        statusCodeResp = 204
                    }
                    
                }
            }
        }
    }
    
}

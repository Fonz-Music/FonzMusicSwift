//
//  CoasterDoesNotHaveHost.swift
//  FonzMusicSwift
//
//  Created by didi on 7/1/21.
//

import SwiftUI
import FirebaseAnalytics

struct CoasterDoesNotHaveHost: View {
    
    // inherited that indicated the tab the app is on
    @Binding var selectedTab: TabIdentifier
    // determines if current user has an account
//    @Binding var hasAccount : Bool
//    // determines if current user is connected to Spotify
//    var connectedToSpotify : Bool
//    // determines if current user is connected to Spotify
//    @Binding var hasConnectedCoasters : Bool
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    
    @Binding var showHomeButtons: Bool
    
    @Binding var launchedNfc: Bool
    
    @Binding var statusCode: Int
    
    // temp Coaster Object so that page does not update BEFORE showing success page
    @Binding var tempCoasterDetails : HostCoasterInfo
    // list of coasters connected to the Host
    @ObservedObject var coastersConnectedToUser: CoastersFromApi
    
    // has user create an account
//    @State var throwCreateAccountModal = false
    
    // has user download the full app
    @State var throwDownloadFullAppModal = false
    
    // has user name their new coaster
    @State var throwNameNewCoasterModal = false
    
    // gives user option to connect their spotify
    @State var throwConnectSpotifyPrompt = false
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.04
    
    var body: some View {
        VStack {
            ZStack{
                Circle()
                    .strokeBorder(Color.lilac, lineWidth: 3)
                    .background(Circle().foregroundColor(colorScheme == .light ? Color.white: Color.darkButton))
                    .frame(width: 125, height: 125)
                    .fonzShadow()
                Image(systemName: "minus")
                    .foregroundColor(.lilac)
                    .font(.system(size: 40))

            }
            .padding()
            VStack{
                Text("this coaster doesn't have a host.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.lilac)
                    .fonzRoundButtonText()
                    .padding(5)
                Text("would you like to become the host?")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.lilac)
                    .fonzRoundButtonText()
                    .padding(5)
            }
            .background(colorScheme == .light ? Color.clear: Color.darkBackground)
            Button {
                #if APPCLIP
                throwDownloadFullAppModal = true
                #else
                if userAttributes.getHasAccount() {
                    print("has account")
                    
                    // if has spotify, add coaster
                    if userAttributes.getConnectedToSpotify() {
                        // add coaster to this users account
                        let addCoasterResult = HostCoastersApi().addCoaster(coasterUid: tempCoasterDetails.uid)
                            print("\(String(describing: addCoasterResult.statusCode)) is the code m8")
                            // return that resp if its NOT 200
                        print("status here is \(addCoasterResult.statusCode)")
                            if addCoasterResult.statusCode == 200 {
                                // have user name coaster
                                throwNameNewCoasterModal = true
                                
                            }
                            else {
                                // tell user something went wrong connecting
                                statusCode = 405
                                withAnimation {
                                    launchedNfc = false
//                                    showHomeButtons = true
                                }
                            }
                    }
                    // if they DONT have spotify
                    else {
                        // ask if they wanna launch spotify
                        throwConnectSpotifyPrompt = true
                    }
                    FirebaseAnalytics.Analytics.logEvent("userTriedJoiningPartyCoasterNoHost", parameters: ["user":"user", "tab":"search"])

                }
                else {
                    print("no account")
                    userAttributes.showSignUpModal = true
//                    throwCreateAccountModal = true
                }
                
                #endif

            } label: {
                Text("connect")
                    .foregroundColor(Color.white)
                    .fonzParagraphTwo()
                    .frame(width: UIScreen.screenWidth * 0.5, height: 40, alignment: .center)
//                    .padding()
            }
            
            .buttonStyle(BasicFonzButton(bgColor: .lilac, secondaryColor: colorScheme == .light ? Color.white: Color.darkButton))
            .padding()
            Button {
                withAnimation {
                    showHomeButtons = true
                    launchedNfc = false
                }

            } label: {
                Text("no thanks")
                    .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                    .fonzParagraphTwo()
                    .frame(width: UIScreen.screenWidth * 0.5, height: 40, alignment: .center)
//                    .padding()
            }
            
            .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .lilac))
//            .padding()
        }
//        .sheet(isPresented: $throwCreateAccountModal, onDismiss: {
//        }) {
//            CreateAccountPrompt(userAttributes: userAttributes, showModal: $throwCreateAccountModal)
//        }
        .sheet(isPresented: $throwDownloadFullAppModal) {
            DownloadFullAppPrompt()
        }
        .sheet(isPresented: $throwConnectSpotifyPrompt, onDismiss: {
            // if they dont add spot
            if !userAttributes.getConnectedToSpotify() {
                withAnimation {
                    launchedNfc = false
                    showHomeButtons = true
                }
            }
            // if they do have spot
            else {
                let addCoasterResult = HostCoastersApi().addCoaster(coasterUid: tempCoasterDetails.uid)
//                    print("\(String(describing: addCoasterResult.status)) is the code m8")
                    // return that resp if its NOT 200
                print("status here is \(addCoasterResult.statusCode)")
                    if addCoasterResult.statusCode == 200 {
                        // have user name coaster
                        throwNameNewCoasterModal = true
                        
                    }
                    else {
                        // tell user something went wrong connecting
                        statusCode = 405
                        withAnimation {
                            launchedNfc = false
//                                    showHomeButtons = true
                        }
                    }
            }
            
        }) {
            AskUserToConnectSpotify(showModal: $throwConnectSpotifyPrompt)
        }
        .sheet(isPresented: $throwNameNewCoasterModal, onDismiss: {
            withAnimation {
                showHomeButtons = true
                launchedNfc = false
                userAttributes.setHasConnectedCoasters(bool: true)
//                userAttributes.determineIfUserHasConnectedCoasters()
//                hasConnectedCoasters = true
            }
//            UserDefaults.standard.set(true, forKey: "hasConnectedCoasters")
        }) {
            VStack{
                Spacer()
                    .frame(maxHeight: 50)
                NameNewCoaster(launchedNfc: $throwNameNewCoasterModal, coasterUid: tempCoasterDetails.uid, coastersConnectedToHost: coastersConnectedToUser)
                Spacer()
            }
            .background(
                ZStack{
                    Color.lilac
                    VStack{
                        Spacer()
                        Image("mountainProfile")
                            .opacity(0.4)
                            .frame(maxWidth: UIScreen.screenWidth)
                    }
                }, alignment: .bottom)
            .ignoresSafeArea()
        }
    }
}

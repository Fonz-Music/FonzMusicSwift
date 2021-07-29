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
    @Binding var hasAccount : Bool
    // determines if current user is connected to Spotify
    var connectedToSpotify : Bool
    // determines if current user is connected to Spotify
    @Binding var hasConnectedCoasters : Bool
    
    @Binding var showHomeButtons: Bool
    
    @Binding var launchedNfc: Bool
    
    @Binding var statusCode: Int
    
    // temp Coaster Object so that page does not update BEFORE showing success page
    @Binding var tempCoasterDetails : HostCoasterInfo
    // list of coasters connected to the Host
    @ObservedObject var coastersConnectedToUser: CoastersFromApi
    
    // has user create an account
    @State var throwCreateAccountModal = false
    
    // has user download the full app
    @State var throwDownlaodFullAppModal = false
    
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
                throwDownlaodFullAppModal = true
                #else
                if hasAccount {
                    print("has account")
                    
                    // if has spotify, add coaster
                    if connectedToSpotify {
                        // add coaster to this users account
                        let addCoasterResult = HostCoasterApi().addCoaster(coasterUid: tempCoasterDetails.uid)
                            print("\(String(describing: addCoasterResult.status)) is the code m8")
                            // return that resp if its NOT 200
                        print("status here is \(addCoasterResult.status)")
                            if addCoasterResult.status == 200 {
                                // have user name coaster
                                throwNameNewCoasterModal = true
                                
                            }
                            else {
                                // tell user something went wrong connecting
                                statusCode = 405
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
                    throwCreateAccountModal = true
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
        .sheet(isPresented: $throwCreateAccountModal, onDismiss: {
        }) {
            CreateAccountPrompt(hasAccount: $hasAccount, showModal: $throwCreateAccountModal)
        }
        .sheet(isPresented: $throwDownlaodFullAppModal) {
            DownloadFullAppPrompt()
        }
        .sheet(isPresented: $throwConnectSpotifyPrompt, onDismiss: {
            
            if !connectedToSpotify {
                withAnimation {
                    launchedNfc = false
                    showHomeButtons = true
                }
            }
            
        }) {
            AskUserToConnectSpotify()
        }
        .sheet(isPresented: $throwNameNewCoasterModal, onDismiss: {
            withAnimation {
                showHomeButtons = true
                launchedNfc = false
                hasConnectedCoasters = true
            }
            UserDefaults.standard.set(true, forKey: "hasConnectedCoasters")
        }) {
            VStack{
                Spacer()
//                    .frame(maxHeight: 100)
                NameNewCoaster(launchedNfc: $launchedNfc, coasterUid: tempCoasterDetails.uid, coastersConnectedToHost: coastersConnectedToUser)
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

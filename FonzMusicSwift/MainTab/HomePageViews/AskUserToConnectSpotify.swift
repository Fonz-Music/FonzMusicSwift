//
//  AskUserToConnectSpotify.swift
//  FonzMusicSwift
//
//  Created by didi on 7/26/21.
//

import SwiftUI
import FirebaseAnalytics


struct AskUserToConnectSpotify: View {
    // so you can dismiss modal
    @Binding var showModal : Bool
    let sideGraphicHeight = UIScreen.screenHeight * 0.14
    
    var body: some View {
        ZStack{
            VStack{
//                HStack{
//                    Text("Fonz Music")
//                        .foregroundColor(.darkButton).fonzParagraphOne()
//                        .padding(.headingFrontIndent)
//                        .padding(.top, .headingTopIndent)
//                        .padding(.bottom, 20)
//                    Spacer()
//                }
                Spacer()
                    .frame(height: 150)
                Image("spotifyIcon").resizable().frame(width: sideGraphicHeight, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding()
                Text("you need to connect to Spotify")
                    .foregroundColor(.darkButton)
                    .font(Font.custom("MuseoSans-500", size: 28))
                    .multilineTextAlignment(.center)
//                    .fonzHeading()
                    .padding(.headingFrontIndent)
                Button(action: {
//                    HostFonzSessionApi().getAllSessions()

                    FirebaseAnalytics.Analytics.logEvent("userTappedConnectSpotify", parameters: ["user":"user", "tab":"host"])
                    SpotifySignInFunctions().launchSpotifyInBrowser()
                    showModal = false
                }, label: {
                    Text("connect")
                        .foregroundColor(.white)
                        .fonzParagraphOne()
                        .padding(15)
                }).buttonStyle(BasicFonzButton(bgColor:  .darkButton, secondaryColor: .white))
                Spacer()
            }
        }
        .background(
            ZStack{
                Rectangle()
                    .fill(LinearGradient(
                        gradient: .init(colors: [.lilac, .lilacDark]),
                        startPoint: .topLeading,
                          endPoint: .bottomTrailing
                        ))
                    // darkens background when typing
//                    .darkenView(isEditingSearchBar)
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

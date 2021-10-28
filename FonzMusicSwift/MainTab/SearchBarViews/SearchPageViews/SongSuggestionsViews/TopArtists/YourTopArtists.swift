//
//  YourFavoriteArtists.swift
//  FonzMusicSwift
//
//  Created by didi on 6/22/21.
//

import SwiftUI
//import Firebase
import FirebaseAnalytics

struct YourTopArtists: View {
    
    // hostCoaster details passed in and will update view when changed
    @StateObject var hostCoaster:HostCoasterInfo
    
    // object that stores the songs from the api
    @StateObject var tracksFromArtist: TracksFromArtist
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    @State var connectedToSpotify : Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    // object that stores the songs from the api
    @ObservedObject var guestTopArtists: GuestTopArtists
   //
    var body: some View {
        VStack {
            HStack{
                Text(connectedToSpotify ? "your top artists" : "fonz top artists")
                    .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                    .fonzParagraphTwo()
                    .padding(.horizontal, .subHeadingFrontIndent)
                    .padding(.bottom, 10)
                    .padding(.top, 10)

                Spacer()
            }
            
                ZStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(guestTopArtists.products, id: \.self) { artist in
                                TopArtistView(hostCoaster: hostCoaster, artistIn: artist.toArtist(),  tracksFromArtist: tracksFromArtist, userAttributes: userAttributes)
                            }

                            if connectedToSpotify {
                //                .padding(.horizontal, 5)
                                Button(action: {
                                    guestTopArtists.loadMoreArtists()
                                }, label: {
                                    
                                        
                                    // load more
                                    VStack(alignment: .center) {
                                        Spacer()
                                        Image(systemName: "arrow.clockwise")
                                            .padding(.horizontal, 10)
                                            .padding(.top, 10)
                                            .foregroundColor(.amber)
                                        Spacer()
                                        Text("load more")
                                            .foregroundColor(.amber)
                                            .fonzParagraphThree()
                                        Spacer()
                                    }
                                    .frame(width: UIScreen.screenWidth * 0.25, height: UIScreen.screenWidth * 0.25)
                                    .animation(.easeIn)
                                })
                                .buttonStyle(BasicFonzButtonCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
                                .padding(.trailing, 5)
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical)
                }
                .background(
                    RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                        .fill(colorScheme == .light ? Color.white: Color.darkButton)
                        .padding(.horizontal, .subHeadingFrontIndent)
                        .frame(width: UIScreen.screenWidth, height: 150, alignment: .center)
                        .fonzShadow()
                    , alignment: .top
                )
                .padding(.horizontal)
                .padding(.bottom)
        }
        .onAppear {
           connectedToSpotify = UserDefaults.standard.bool(forKey: "connectedToSpotify")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                if guestTopArtists.loadArtists {
                    guestTopArtists.loadTopArtists()
                    guestTopArtists.loadArtists = false
                }
                
            }
        }
    }
}


//
//  SearchBar.swift
//  FonzMusicSwift
//
//  Created by didi on 6/15/21.
//


import SwiftUI

struct SearchBar: View {
// ---------------------------------- inherited from parent -----------------------------------------

    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    // checks if guest has a host
    @Binding var hasHostVar : Bool
    
// ---------------------------------- created inside view -------------------------------------------
    // object that stores the songs from the api
    @ObservedObject var tracksFromSearch: TracksFromSearch = TracksFromSearch()
    @State var scale: CGFloat = 1
    @Environment(\.colorScheme) var colorScheme
    
    // boolean to change when views should be showed w animation
    @State var hideViews = true
    
    // checks to see if currently typing in searchbar
    @State var isEditingSearchBar = false
    
    
    
        var body: some View {
            // entire page is a scrollView
            ScrollView(showsIndicators: false) {
                ZStack {
                    // background gradient
                    Rectangle()
                        .fill(LinearGradient(
                            gradient: .init(colors: [.amber, .lilac]),
                            startPoint: .topLeading,
                              endPoint: .bottomTrailing
                            ))
                        // darkens background when typing
                        .darkenView(isEditingSearchBar)
                VStack {
                    // top search headar & quit part button
                    ZStack {
                        HStack{
                            Text("search")
                                .foregroundColor(Color.white)
                                .fonzParagraphOne()
                                .padding(25)
                            Spacer()
                        }.padding(.top, 40)
                        HStack{
                            Spacer()
                            Button {
                                withAnimation {
                                    hasHostVar = false
                                }
                            } label: {
                                Text("leave party")
                                    .fonzParagraphTwo()
                                    .padding(25)

                            }
                        }.padding(.top, 40)
                        
                        
                    }
                    // search bar widget
                    SearchBarView(tracksFromSearch: tracksFromSearch, isEditing: $isEditingSearchBar)
                    ZStack {
                        // now playing + song suggestions
                        VStack{
                            ActiveSongView(hostName: $hostCoaster.hostName)
                            SongSuggestionsView(hostCoaster: hostCoaster)
                        }
                        .isHidden(hideViews)
                        .addOpacity(isEditingSearchBar)
                        
                        
                        // search results
                        VStack {
                            SearchResultsView(tracksFromSearch: tracksFromSearch, hostCoaster: hostCoaster)
                            Spacer()
                        }
                    }
                }
            }
            .onAppear {
                // disables bounce
                UIScrollView.appearance().bounces = false
                // passes the sessionId from the host into the results return
                tracksFromSearch.tempSession = hostCoaster.sessionId
                // waits .5 seconds before showing views
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        hideViews = false
                    }
                }
            }
        }
            .ignoresSafeArea()
    }
}

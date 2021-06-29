//
//  HostTab.swift
//  FonzMusicSwift
//
//  Created by didi on 6/16/21.
//

import SwiftUI

struct HostTab: View {
    
// ---------------------------------- created inside view -------------------------------------------
        // object that stores the songs from the api
//        @ObservedObject var hostCoasterList: CoastersFromApi = CoastersFromApi()
    
    @State var connectedToSpotify = true
    
    @State var hasConnectedCoasters = false
    
    // object that stores the songs from the api
    @ObservedObject var hostCoasterList: CoastersFromApi = CoastersFromApi()
    
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            
            if (!connectedToSpotify || !hasConnectedCoasters) {
                HStack{
                    Text("host")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzParagraphOne()
                        .padding(25)
                        .padding(.top, 40)
                    Spacer()
                }
                
                HostSetup(connectedToSpotify: $connectedToSpotify, hasConnectedCoasters: $hasConnectedCoasters)
            }
            else {
                HStack{
                    Text("coasters")
                        .foregroundColor(.white)
                        .fonzParagraphOne()
                        .padding(25)
                        .padding(.top, 40)
                        .padding(.bottom, 20)
                    Spacer()
                }
                CoasterDashboardPage(hostCoasterList: hostCoasterList)
            }
            Spacer()
        }
        .background(
            ZStack{
                if (connectedToSpotify && hasConnectedCoasters) {
                    Color.lilac
                }
                else {
                    Color(UIColor(colorScheme == .light ? Color.white: Color.darkBackground))
                }
                Image("mountainProfile")
                    .opacity(0.4)
                    .frame(maxWidth: UIScreen.screenWidth)
            }, alignment: .bottom)
        .ignoresSafeArea()
    }
}

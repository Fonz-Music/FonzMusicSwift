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
    
    @State var connectedToSpotify = false
    
    @State var hasConnectedCoasters = false
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.amber)
            VStack {
                
                if (!connectedToSpotify || !hasConnectedCoasters) {
                    HStack{
                        Text("host")
                            .foregroundColor(Color.white)
                            .fonzParagraphOne()
                            .padding(25)
                            .padding(.top, 40)
                        Spacer()
                    }
                    HostSetup()
                }
                else {
                    HStack{
                        Text("host")
                            .foregroundColor(Color.white)
                            .fonzParagraphOne()
                            .padding(25)
                            .padding(.top, 40)
                            .padding(.bottom, 20)
                        Spacer()
                    }
    //                CoasterDashboard()
                }
                Spacer()
            }
        }
        .ignoresSafeArea()
        .onAppear {
//            hostCoasterList.firstTimeLoadCoasters()
            print("reloaded")
        }
    }
}

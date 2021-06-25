//
//  OwnedCoasterDropItem.swift
//  FonzMusicSwift
//
//  Created by didi on 6/24/21.
//

import SwiftUI

struct OwnedCoasterDropItem: View {

    // the song passed in
    let item: HostCoasterResult
    var isExpanded: Bool
    @ObservedObject var coasterFromSearch: CoastersFromApi
    
    @State var showRenameModal = false
    @State var showPauseModal = false
    @State var showDisconnectModal = false
    
    @Environment(\.colorScheme) var colorScheme
  
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 10) {
                    // coaster w lilac gradiant
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .fill(LinearGradient(
                                gradient: .init(colors: [.lilac, Color.purple]),
                                startPoint: .topLeading,
                                  endPoint: .bottomTrailing
                                ))
                        Image("coasterIcon").resizable()
                            .frame( width: 35 ,height: 25).padding(5)
                    }.frame( width: 50)
                    
                    // coaster bane
                    Text(verbatim: item.name)
                        .foregroundColor(determineColorOffPause(paused: item.paused))
                        .fonzParagraphTwo()
                    Spacer()
                }
                if isExpanded {
                    VStack {
                        Button {
                            print("rename")
                            showRenameModal = true
                        } label: {
                            HStack(spacing: 5) {
                                // album art
                                Image("renameIcon").resizable()
                                    .frame( width: 30 ,height: 30).padding(.leading, 30)
                                // title & artist
                                Text("rename")
                                    .fonzParagraphTwo()
                                Spacer()
                            }.padding(.vertical, 10)
                        }.sheet(isPresented: $showRenameModal, content: {
                            NameCoaster(coasterUid: item.coasterId, isPresented: $showRenameModal, coasterFromSearch: coasterFromSearch)
                        })
                        // pause button
                        Button {
                            print("pause")
                            showPauseModal = true
                        } label: {
                            HStack(spacing: 5) {
                                // album art
                                Image("pauseIcon").resizable()
                                    .frame( width: 30 ,height: 30).padding(.leading, 30)
                                // title & artist
                                Text(determineTextOffPause(paused: item.paused))
                                    .fonzParagraphTwo()
                                Spacer()
                            }.padding(.vertical, 10)
                        }.sheet(isPresented: $showPauseModal, content: {
                            PauseCoaster(coasterName: item.name, coasterUid: item.coasterId, paused: !item.paused, isPresented: $showPauseModal, coasterFromSearch: coasterFromSearch)
                        })
                        // disconnect button
                        Button {
                            print("disconnect")
                            showDisconnectModal = true
                        } label: {
                            HStack(spacing: 5) {
                                // album art
                                Image("disableIcon").resizable()
                                    .frame( width: 30 ,height: 30).padding(.leading, 30)
                                // title & artist
                                Text("disconnect")
                                    .fonzParagraphTwo()
                                Spacer()
                            }.padding(.vertical, 10)
                        }.sheet(isPresented: $showDisconnectModal, content: {
                            DisconnectCoaster(coasterName: item.name, coasterUid: item.coasterId, isPresented: $showDisconnectModal, coasterFromSearch: coasterFromSearch)
                        })
                    }
                }
            }
        }
        .frame(minHeight: 50, maxHeight: 350)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(colorScheme == .light ? Color.white: Color.darkButton)
                .shadow(color: Color.black.opacity(0.04), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 7)
        )
        .padding(.horizontal, 10)
        .animation(.easeIn)
        
    }
    func determineColorOffPause(paused:Bool) -> Color {
        if paused {
            return Color.gray
        }
        else { return colorScheme == .light ? Color.darkButton  : Color.white}
    }
    func determineTextOffPause(paused:Bool) -> String {
        if paused {
            return "unpause"
        }
        else { return "pause" }
    }
    
   
}

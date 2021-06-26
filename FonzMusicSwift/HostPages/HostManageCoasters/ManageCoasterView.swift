//
//  ManageCoasterView.swift
//  FonzMusicSwift
//
//  Created by didi on 4/29/21.
//

import SwiftUI

struct ManageCoasterView: View {
    // the song passed in
    let item: HostCoasterResult
    var isExpanded: Bool
    @ObservedObject var coasterFromSearch: CoastersFromApi
    
    @State var showRenameModal = false
    @State var showPauseModal = false
    @State var showDisconnectModal = false
  
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 5) {
                    // album art
                    Image("coasterIcon").resizable()
                        .frame( width: 60 ,height: 50).padding(5)
                    // title & artist
                    Text(verbatim: item.name)
                        .foregroundColor(determineColorOffPause(paused: item.paused))
                        .fonzParagraphOne()
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
        .frame(minHeight: 70, maxHeight: 350)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.amber)
                .fonzShadow()
        )
        .padding(.horizontal, 10)
        .animation(.easeIn)
        
    }
    func determineColorOffPause(paused:Bool) -> Color {
        if paused {
            return Color.gray
        }
        else { return Color(.systemGray5) }
    }
    func determineTextOffPause(paused:Bool) -> String {
        if paused {
            return "unpause"
        }
        else { return "pause" }
    }
    
   
}

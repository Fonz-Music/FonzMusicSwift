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
    
    @State var showRenameModal = false
    @State var showPauseModal = false
    @State var showDisconnectModal = false
    
    var isExpanded: Bool
  
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 5) {
                    // album art
                    Image("coasterIcon").resizable()
                        .frame( width: 60 ,height: 50).padding(5)
                    // title & artist
                    Text(verbatim: item.name)
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
                            NameCoaster(coasterUid: item.coasterId, isPresented: $showRenameModal)
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
                                Text("pause")
                                    .fonzParagraphTwo()
                                Spacer()
                            }.padding(.vertical, 10)
                        }.sheet(isPresented: $showPauseModal, content: {
                            PauseCoaster(coasterName: item.name, coasterUid: item.coasterId, paused: !item.active, isPresented: $showPauseModal)
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
                            DisconnectCoaster(coasterName: item.name, coasterUid: item.coasterId, isPresented: $showDisconnectModal)
                        })
                    }
                }
            }
        }
        .frame(minHeight: 70, maxHeight: 350)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.amber)
                .shadow(color: Color.black.opacity(0.04), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 7)
        )
        .padding(.horizontal, 10)
        .animation(.easeIn)
        
    }
    
   
}

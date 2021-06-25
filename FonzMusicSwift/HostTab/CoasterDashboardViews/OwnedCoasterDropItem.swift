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
                // top line
                if isExpanded {
                    HStack{
                        // coaster bane
                        Text(verbatim: item.name)
                            .foregroundColor(.white)
                            .fonzParagraphTwo()
                            .padding(.leading, 20)
                        Spacer()
                        Image("coasterIcon").resizable()
                            .frame( width: 35 ,height: 25).padding(.horizontal, 15)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 2)
                            .fill(LinearGradient(
                                gradient: .init(colors: [.lilac, Color.purple]),
                                startPoint: .topLeading,
                                  endPoint: .bottomTrailing
                                ))
                            .frame(height: 50)
                    )
                    .frame(height: 50)
                }
                else {
                    HStack(spacing: 10) {
                        // coaster w lilac gradiant
                        ZStack{
                            
                            Image("coasterIcon").resizable()
                                .frame( width: 35 ,height: 25).padding(5)
                        }
                        .background(
                            Rectangle()
                                .fill(LinearGradient(
                                    gradient: .init(colors: [.lilac, Color.purple]),
                                    startPoint: .topLeading,
                                      endPoint: .bottomTrailing
                                )).frame(width: 50, height: 50)
                        )
                        .frame( width: 50, height: 50)
                        
                        // coaster bane
                        Text(verbatim: item.name)
                            .foregroundColor(determineColorOffPause(paused: item.paused))
                            .fonzParagraphTwo()
                        Spacer()
                    }.frame(height: 50)
                
                }
                if isExpanded {
                    VStack {
                        Button {
                            print("rename")
                            showRenameModal = true
                        } label: {
                            HStack(spacing: 5) {
                                // button name
                                Text("rename")
                                    .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                                    .fonzParagraphTwo()
                                    .padding(.horizontal, 20)
                                Spacer()
                                Image("renameIcon").resizable()
                                    .frame( width: 25, height: 25)
                                    .padding(.horizontal, 20)
                            }.padding(.vertical, 10)
                        }
                        .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .lilac))
                        .sheet(isPresented: $showRenameModal, content: {
                            NameCoaster(coasterUid: item.coasterId, isPresented: $showRenameModal, coasterFromSearch: coasterFromSearch)
                        })
                        // pause button
                        Button {
                            print("pause")
                            showPauseModal = true
                        } label: {
                            HStack(spacing: 5) {
                                // button name
                                Text(determineTextOffPause(paused: item.paused))
                                    .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                                    .fonzParagraphTwo()
                                    .padding(.horizontal, 20)
                                Spacer()
                                Image("pauseIcon").resizable()
                                    .frame( width: 25, height: 25)
                                    .padding(.horizontal, 20)
                            }.padding(.vertical, 10)
                        }
                        .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .lilac))
                        .sheet(isPresented: $showPauseModal, content: {
                            PauseCoaster(coasterName: item.name, coasterUid: item.coasterId, paused: !item.paused, isPresented: $showPauseModal, coasterFromSearch: coasterFromSearch)
                        })
                        // troubleshoot button
                        Button {
                            print("troubleshoot")
//                            showPauseModal = true
                        } label: {
                            HStack(spacing: 5) {
                                // button name
                                Text("troubleshoot")
                                    .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                                    .fonzParagraphTwo()
                                    .padding(.horizontal, 20)
                                Spacer()
                                Image("coasterIcon").resizable()
                                    .frame( width: 25, height: 25)
                                    .padding(.horizontal, 20)
                            }.padding(.vertical, 10)
                        }
                        .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .lilac))
//                        .sheet(isPresented: $showPauseModal, content: {
//                            PauseCoaster(coasterName: item.name, coasterUid: item.coasterId, paused: !item.paused, isPresented: $showPauseModal, coasterFromSearch: coasterFromSearch)
//                        })
                        // disconnect button
                        Button {
                            print("disconnect")
                            showDisconnectModal = true
                        } label: {
                            HStack(spacing: 5) {
                                // button name
                                Text("disable")
                                    .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                                    .fonzParagraphTwo()
                                    .padding(.horizontal, 20)
                                Spacer()
                                Image("disableIcon").resizable()
                                    .frame( width: 25, height: 25)
                                    .padding(.horizontal, 20)
                                
                                
                            }.padding(.vertical, 10)
                        }
                        .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .lilac))
                        .sheet(isPresented: $showDisconnectModal, content: {
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

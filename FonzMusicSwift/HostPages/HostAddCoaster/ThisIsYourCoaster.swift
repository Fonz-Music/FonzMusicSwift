//
//  ThisIsYourCoaster.swift
//  FonzMusicSwift
//
//  Created by didi on 4/27/21.
//

import SwiftUI

struct ThisIsYourCoaster: View {
    let coaster:HostCoasterInfo
    @ObservedObject var coasterFromSearch: CoastersFromApi
    
    
    @State var showRenameModal = false
    @State var showPauseModal = false
    @State var showDisconnectModal = false
    
    let imageHeight = UIScreen.screenHeight * 0.1
    
    var body: some View {
                ZStack {
                    Color.amber.ignoresSafeArea()
                    VStack{
//                        Spacer()
                        Image("fonzLogoF").resizable()
                            .frame(width: imageHeight * 0.5, height: imageHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(.top, UIScreen.screenHeight * 0.2)
                            
                        
                        
                        Text("this is your coaster").fonzParagraphOne()
                 
                        Text("\(coaster.coasterName)").fonzHeading().padding(.top, UIScreen.screenHeight * 0.1)
                        Spacer()
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
                                NameCoaster(coasterUid: coaster.uid, isPresented: $showRenameModal, coasterFromSearch: coasterFromSearch)
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
                                    Text(determineTextOffPause(paused: true))
                                        .fonzParagraphTwo()
                                    Spacer()
                                }.padding(.vertical, 10)
                            }.sheet(isPresented: $showPauseModal, content: {
                                PauseCoaster(coasterName: coaster.coasterName, coasterUid: coaster.uid, paused: true, isPresented: $showPauseModal, coasterFromSearch: coasterFromSearch)
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
                                DisconnectCoaster(coasterName: coaster.coasterName, coasterUid: coaster.uid, isPresented: $showDisconnectModal, coasterFromSearch: coasterFromSearch)
                            })
                        }.padding(.horizontal, UIScreen.screenWidth * 0.2)
                    }
                }
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

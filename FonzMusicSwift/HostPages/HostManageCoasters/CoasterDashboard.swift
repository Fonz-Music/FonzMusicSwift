//
//  CoasterDashboard.swift
//  FonzMusicSwift
//
//  Created by didi on 4/27/21.
//

import SwiftUI

struct CoasterDashboard: View {
// ---------------------------------- inherited from parent -----------------------------------------
    // inherited from parent to see active page. so that user can change pages at
    // top to add a new coaster
    @Binding var hostPageNumber:Int
    
// ---------------------------------- created inside view -------------------------------------------
    // object that stores the songs from the api
    @ObservedObject var coasterFromSearch: CoastersFromApi = CoastersFromApi()
    // if pressed
   @State var isExpanded = false
    // for the results of the search bar
    let layout = [
            GridItem(.flexible())
        ]
    @State private var selection: Set<CoasterInfo> = []
    // scaled height of icon
    let imageHeight = UIScreen.screenHeight * 0.15
    
    var body: some View {
        ZStack {
            Color.amber.ignoresSafeArea()
        
            VStack {
                // spotify button
                Button(action: {
                    print("pressed button")
                }, label: {
                    Text("spotify")
                        .fonzSubheading()
                })
                .buttonStyle(NeumorphicButtonStyle(bgColor: .amber))
                .padding(.top, 10)
                .padding(.bottom, 25)
                //title
                Text("coasters").fonzHeading()
                Text("manage your devices").fonzParagraphOne()
                
                // list view from searching song
                if coasterFromSearch.products.count > 0 {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: layout, spacing: 12) {
                            ForEach(coasterFromSearch.products, id: \.self) { item in
//
//                                Button(action: {
//                                    print("button pressed: " )
//                                    isExpanded = true
//                                }, label: {
                                ManageCoasterView(item: item, isExpanded: self.selection.contains(item))
                                        .onTapGesture {
                                            self.selectDeselect(item)
                                        }
                                        .animation(.linear(duration: 0.3))
//                                })
                                // launches queueSongSheet after song is selected
                                
                            }
                        }
                    }.frame(width: UIScreen.screenWidth * 0.9, height: UIScreen.screenHeight * 0.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
                // what is shown if nothing has been searched
                else {
                    Spacer()
                }
                
                // button to return you to searchbar if you dont want to connect to a new host
                Button(action: {
                    self.hostPageNumber = 1
                }, label: {
                    VStack {
                        Text("connect a coaster").fonzParagraphOne()
                    Image("arrowDown").resizable()
                        .frame(width: imageHeight * 0.4, height: imageHeight * 0.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }).padding()
            }
        }
    }
    private func selectDeselect(_ coaster: CoasterInfo) {
            if selection.contains(coaster) {
                selection.remove(coaster)
            } else {
                selection.insert(coaster)
            }
        }
}

struct CoasterDashboard_Previews: PreviewProvider {
    static var previews: some View {
//        CoasterDashboard(hostPageNumber: <#T##Binding<Int>#>)
        Text("heyo")
    }
}

struct ManageCoasterView: View {
    // the song passed in
    let item: CoasterInfo
    
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
                    Text(verbatim: item.coasterName)
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
                            NameCoaster(coasterUid: item.uid)
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
                            PauseCoaster(coasterName: item.coasterName, coasterUid: item.uid, paused: !item.active!, isPresented: $showPauseModal)
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
                            DisconnectCoaster(coasterName: item.coasterName, coasterUid: item.uid, isPresented: $showDisconnectModal)
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



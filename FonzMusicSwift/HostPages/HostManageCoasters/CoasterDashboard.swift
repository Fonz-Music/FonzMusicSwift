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
    // for the results of the search bar
    let layout = [
            GridItem(.flexible())
        ]
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
                                Button(action: {
                                    print("button pressed: " )
                                    
                                }, label: {
                                    ManageCoasterView(item: item)
                                })
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
                    Image("Arrow Down White").resizable()
                        .frame(width: imageHeight * 0.4, height: imageHeight * 0.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }).padding()
            }
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
  
    var body: some View {
        ZStack {
            HStack(spacing: 5) {
                // album art
                Image("coasterIconWhite").resizable()
                    .frame( width: 60 ,height: 50).padding(5)
                // title & artist
                
                Text(verbatim: item.coasterName)
                    .fonzParagraphOne()
                
                
                Spacer()
            }
        }
        .frame(height: 70)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.amber)
                .shadow(color: Color.black.opacity(0.04), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 7)
        )
        .padding(.horizontal, 10)
        .animation(.easeIn)
        
    }
}



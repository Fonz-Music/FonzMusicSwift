//
//  CoasterDashboard.swift
//  FonzMusicSwift
//
//  Created by didi on 4/27/21.
//

import SwiftUI

struct CoasterDashboard: View {
// ---------------------------------- inherited from parent -----------------------------------------
    // gets object to determine if the page should be updated
    @Binding var determineHostViewUpdate: UpdatePageViewVariables
    // inherited from parent to see active page. so that user can change pages at
    // top to add a new coaster
    @Binding var hostPageNumber:Int
    
// ---------------------------------- created inside view -------------------------------------------
    // object that stores the songs from the api
    @ObservedObject var hostCoasterList: CoastersFromApi
    // for the results of the search bar
    let layout = [
            GridItem(.flexible())
        ]
    @State private var selection: Set<HostCoasterResult> = []
    
    // scaled height of icon
    let imageHeight = UIScreen.screenHeight * 0.15
    
    var body: some View {
        ZStack {
            Color.amber.ignoresSafeArea()
        
            VStack {
                // spotify button
//                Button(action: {
//                    print("pressed button")
//                }, label: {
//                    Text("spotify")
//                        .fonzSubheading()
//                })
//                .buttonStyle(NeumorphicButtonStyle(bgColor: .amber))
//                .padding(.top, 10)
//                .padding(.bottom, 25)
                
                
                // list view from searching song
                if hostCoasterList.products.quantity > 0 {
                    //title
                    Text("coasters").fonzHeading().padding(.top, 50)
                    Text("manage your devices").fonzParagraphOne()
                    // coasters
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: layout, spacing: 12) {

                            ForEach(hostCoasterList.products.coasters, id: \.self) { item in
                                ManageCoasterView(item: item, isExpanded: self.selection.contains(item), coasterFromSearch: hostCoasterList)
                                        .onTapGesture {
                                            self.selectDeselect(item)
                                            
                                        }
                                        .animation(.linear(duration: 0.3))

                            }
                        }
                    }.frame(width: UIScreen.screenWidth * 0.9, height: UIScreen.screenHeight * 0.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Spacer()
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
//                else if spotifyNotLinked {
//                    Text("you're not linked to spot'").fonzSubheading().padding()
//                    // button to link to spot
//                }
                // what is shown if host has spotify but not coasters
                else if hostCoasterList.products.quantity == 0 {
                    Text("coasters").fonzHeading().padding(.top, 50)
                    Text("you don't own any coasters").fonzParagraphOne()
                    HostAddCoaster(determineHostViewUpdate: $determineHostViewUpdate, hostPageNumber: $hostPageNumber, hostCoasterList: hostCoasterList)
                }
                else {
                    Text("loading mate")
                }
                
                
            }
        }
    }
    private func selectDeselect(_ coaster: HostCoasterResult) {
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





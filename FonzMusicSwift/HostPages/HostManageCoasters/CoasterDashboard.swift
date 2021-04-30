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
    @State private var selection: Set<HostCoasterResult> = []
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
                if coasterFromSearch.products.quantity > 0 {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: layout, spacing: 12) {
//                            coasterFromSearch.products.coasters.forEach {
//                                ManageCoasterView(item: $0, isExpanded: self.selection.contains($0))
//                                        .onTapGesture {
//                                            self.selectDeselect($0)
//                                        }
//                                        .animation(.linear(duration: 0.3))
//                            }
                            ForEach(coasterFromSearch.products.coasters, id: \.self) { item in
                                ManageCoasterView(item: item, isExpanded: self.selection.contains(item))
                                        .onTapGesture {
                                            self.selectDeselect(item)
                                        }
                                        .animation(.linear(duration: 0.3))

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





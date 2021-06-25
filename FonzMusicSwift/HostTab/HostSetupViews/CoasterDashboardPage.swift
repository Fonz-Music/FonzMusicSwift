//
//  CoasterDashboardPage.swift
//  FonzMusicSwift
//
//  Created by didi on 6/24/21.
//

import SwiftUI

struct CoasterDashboardPage: View {

// ---------------------------------- inherited from parent -----------------------------------------

    
// ---------------------------------- created inside view -------------------------------------------
    // object that stores the songs from the api
    @ObservedObject var hostCoasterList: CoastersFromApi
    // for the results of the search bar
    let layout = [
            GridItem(.flexible())
        ]
    @State private var selection: Set<HostCoasterResult> = []
    
  
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
         
        VStack {
            Spacer()
                .frame(height: UIScreen.screenHeight * 0.2)
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(colorScheme == .light ? Color.white: Color.darkBackground)
                    
                    .shadow(radius: 3)
                    
                VStack{
                    // coasters
                    ScrollView(showsIndicators: true) {
                        LazyVGrid(columns: layout, spacing: 12) {

                            ForEach(hostCoasterList.products.coasters, id: \.self) { item in
                                OwnedCoasterDropItem(item: item, isExpanded: self.selection.contains(item), coasterFromSearch: hostCoasterList)
                                        .onTapGesture {
                                            self.selectDeselect(item)
                                            
                                        }
                                        .animation(.linear(duration: 0.3))

                            }
                        }
                    }.frame(width: UIScreen.screenWidth * 0.9, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.top, 30)
                    Spacer()
                }
                
            }
            
        }
        .ignoresSafeArea()

        
        
    }
    
    
    private func selectDeselect(_ coaster: HostCoasterResult) {
            if selection.contains(coaster) {
                selection.remove(coaster)
            } else {
                selection.insert(coaster)
            }
        }
}




//
//  SearchBarView.swift
//  FonzMusicSwift
//
//  Created by didi on 6/16/21.
//

import SwiftUI

// search bar & results
struct SearchBarView : View {
    
    // object that stores the songs from the api
    @ObservedObject var tracksFromSearch: TracksFromSearch
    // checks to see if currently typing in searchbar
    @Binding var isEditing : Bool
//    // determines if rest of view should be opague
//    @Binding var addViewOpacity:Bool
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        HStack {
            // search bar
            TextField("queue a song", text: $tracksFromSearch.searchText)
                .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                .fonzParagraphTwo()
                .padding()
                .padding(.horizontal, 25)
                .background(colorScheme == .light ? Color.white: Color.darkButton)
                .cornerRadius(.cornerRadiusTasks)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 16)
                        // if actively editing, show x button to clear
                        if isEditing {
                            Button(action: {
                                self.tracksFromSearch.searchText = ""
                                
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .fonzShadow()
//                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
//                    self.addViewOpacity = true
                }
            // if actively editing, show cancel button
            if isEditing {
                
                Button(action: {
                    withAnimation {
                        self.isEditing = false
                        
                    }
                    hideKeyboard()
                    
                    self.tracksFromSearch.searchText = ""
 
                }) {
                    Text("cancel").fonzParagraphTwo()
                }
//                .padding(.trailing, 10)
                .transition(.opacity)
                .animation(.easeOut)
            }
            Spacer()
        }
        .frame(width: UIScreen.screenWidth * 0.9, alignment: .center)
        .padding(.vertical, 10)
        
        
        
    }
    
}

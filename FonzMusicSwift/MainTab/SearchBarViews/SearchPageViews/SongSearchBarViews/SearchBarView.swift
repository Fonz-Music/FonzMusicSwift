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
    @StateObject var tracksFromSearch: TracksFromSearch
    // checks to see if currently typing in searchbar
    @Binding var isEditing : Bool
//    // determines if rest of view should be opague
//    @Binding var addViewOpacity:Bool
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        HStack {
            // search bar
            TextField("", text: $tracksFromSearch.searchText)
                .placeholder(when: tracksFromSearch.searchText.isEmpty, placeholder: {
                    Text("queue a song")
//                        .foregroundColor(.gray)
                        .foregroundColor(.white)
                        .fonzButtonText()
                })
//                .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                .foregroundColor(.lilac)
                .fonzParagraphTwo()
                .padding()
                .padding(.horizontal, .headingFrontIndent)
//                .background(colorScheme == .light ? Color.white: Color.darkButton)
                .background(Color.amber)
                .cornerRadius(.cornerRadiusTasks)
                .fonzShadow()
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
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
                
//                .padding(.horizontal, 10)
                .onTapGesture {
                    withAnimation{
                        self.isEditing = true
                        tracksFromSearch.offset = 0
                    }
                    
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
//            Spacer()
        }
//        .frame(width: UIScreen.screenWidth * 0.9, alignment: .center)
        .padding(.horizontal, .subHeadingFrontIndent)
        .frame(width: UIScreen.screenWidth, alignment: .center)
        .padding(.vertical, 10)
        
        
        
    }
    
}

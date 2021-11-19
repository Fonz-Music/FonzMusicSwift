//
//  ShopItem.swift
//  FonzMusicSwift
//
//  Created by didi on 11/19/21.
//

import SwiftUI

struct ShopItem: View {
    @Environment(\.colorScheme) var colorScheme
//    @Binding var activeSong : Track
    // object that stores the songs from the api
    var itemFromShop: ItemFromShop
    
    var isExpanded : Bool
    

    
    var body: some View {
        VStack {
                HStack(spacing: 5) {
                    if (itemFromShop.image == "") {
                        HStack{
                            Spacer()
                            Image("spotifyIconAmber")
                            Spacer()
                        }
                        .frame( width: 80 ,height: 80, alignment: .leading)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                    }
                    else {
                        AsyncImage(url: (URL(string:itemFromShop.image))!,
                            placeholder: {
                                HStack{
                                    Spacer()
                                    Image("spotifyIconAmber")
                                    Spacer()
                                }
                            },
                            image: { Image(uiImage: $0).resizable() }
                        )
                        
                        .frame( width: 100 ,height: 100, alignment: .leading)
                        .cornerRadius(.cornerRadiusTasks)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                    }
                    
                    // title & artist
                    VStack(alignment: .leading, spacing: 5) {
                       
                            Text(verbatim: itemFromShop.title)
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                .fonzParagraphOne()
                                .lineLimit(2)
                                
                                .allowsTightening(true)
                            Text(verbatim: itemFromShop.info)
                                .foregroundColor(Color.white)
                                .fonzParagraphTwo()
                       
                    }
                    Spacer()
                    Text("€\(String(Int(itemFromShop.price)))")
                            .foregroundColor(Color.white)
                            .fonzHeading()
                            
//                    Spacer()
                    
                }

            if isExpanded {
                Text(verbatim: itemFromShop.details)
                    .foregroundColor(Color.white)
                    .fonzParagraphTwo()
                // apple pay button here
            }
            
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: .cornerRadiusTasks)
//                .fill(colorScheme == .light ? Color.white: Color.darkButton)
                .fill(Color.darkButton)
                .fonzShadow()
        )
        .padding(10)

        

    }
    func convertSongPositionToString(songPosition : Double) -> String {
        // make double only 2 decimals
        let twoDecimals = Double(round(100*songPosition)/100)
        // creates a string
        var newSongString = String(twoDecimals)
        // replaces all periods w colons for time
        newSongString = newSongString.replacingOccurrences(of: ".", with: ":")
        // creates a sub string of the seconds
        let substring = newSongString.split(separator: ":")
        // if the seconds is 1 digit, adds a zero so time is 4:00 & not 4:0
        if (substring[1].count < 2) {
            newSongString = newSongString + "0"
        }
         
        return newSongString
    }
}

//
//  SongResultItem.swift
//  FonzMusicSwift
//
//  Created by didi on 6/16/21.
//

import SwiftUI

struct SongResultFromSearchItemView: View {
    @Environment(\.colorScheme) var colorScheme
    // the song passed in
    let item: Track
  
    var body: some View {
        ZStack {
            HStack(spacing: 5) {
                // album art
                AsyncImage(url: URL(string: item.albumArt)!,
                           placeholder: { Text("...").fonzParagraphTwo() },
                               image: { Image(uiImage: $0).resizable() })
                    .frame( width: 60 ,height: 60, alignment: .leading).cornerRadius(.cornerRadiusTasks)
                // title & artist
                VStack(alignment: .leading, spacing: 5) {
                    Text(verbatim: item.songName)
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzParagraphTwo()
                    Text(verbatim: item.artistName)
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzParagraphThree()
                }
                Spacer()
            }
        }
        .frame(height: 60)
        .background(
            RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                .fill(colorScheme == .light ? Color.white: Color.darkButton)
                .fonzShadow()
        )
        .padding(.leading, 10)
        .padding(.trailing, 20)
        
        .animation(.easeIn)
        
    }
}

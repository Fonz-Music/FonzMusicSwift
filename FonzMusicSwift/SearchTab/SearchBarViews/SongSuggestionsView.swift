//
//  SongSuggestionsView.swift
//  FonzMusicSwift
//
//  Created by didi on 6/22/21.
//

import SwiftUI

struct SongSuggestionsView: View {
    
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(colorScheme == .light ? Color.white: Color.darkButton)
                .frame(height: 900, alignment: .center)
                .shadow(radius: 3)
                .padding(.top, 30)
            VStack{
                YourTopSongs(hostCoaster: hostCoaster)
                YourFavoriteArtists(hostCoaster: hostCoaster)
                YourTopPlaylists(hostCoaster: hostCoaster)
                Spacer()
            }
        }
    }
}


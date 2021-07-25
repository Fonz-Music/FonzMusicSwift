//
//  PauseCoasterButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/25/21.
//

import SwiftUI

struct PauseCoasterButton: View {
    
    // the song passed in
    let item: HostCoasterResult
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var showPauseModal : Bool
    
    
    var body: some View {
    Button {
        print("pause")
        showPauseModal = true
    } label: {
        HStack(spacing: 5) {
            // button name
            Text(determineTextOffPause(paused: item.paused))
                .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                .fonzParagraphTwo()
                .padding(.horizontal, 20)
            Spacer()
            Image("pauseIcon").resizable()
                .frame( width: 25, height: 25)
                .padding(.horizontal, 20)
        }.padding(.vertical, 10)
    }
//    .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .lilac))
    }
    
    func determineColorOffPause(paused:Bool) -> Color {
        if paused {
            return Color.gray
        }
        else { return colorScheme == .light ? Color.darkButton  : Color.white}
    }
    func determineTextOffPause(paused:Bool) -> String {
        if paused {
            return "unpause"
        }
        else { return "pause" }
    }
}

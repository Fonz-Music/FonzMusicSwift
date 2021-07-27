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
            Text(determineTextOffPause(active: item.active))
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
    
    func determineColorOffPause(active:Bool) -> Color {
        if !active {
            return Color.gray
        }
        else { return colorScheme == .light ? Color.darkButton  : Color.white}
    }
    func determineTextOffPause(active:Bool) -> String {
        if active {
            return "pause"
        }
        else { return "unpause" }
    }
}

//
//  TroubleShootCoasterButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/25/21.
//

import SwiftUI

struct TroubleShootCoasterButton: View {
    
    @Binding var showTroubleShootModal : Bool
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button {
            print("troubleshoot")
                showTroubleShootModal = true
        } label: {
            HStack(spacing: 5) {
                // button name
                Text("troubleshoot")
                    .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                    .fonzParagraphTwo()
                    .padding(.horizontal, 20)
                Spacer()
                Image("coasterIcon").resizable()
                    .frame( width: 25, height: 20)
                    .padding(.horizontal, 20)
            }.padding(.vertical, 10)
        }
//        .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .lilac))
    }
}

//
//  RenameCoasterButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/25/21.
//

import SwiftUI

struct RenameCoasterButton: View {
    
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var showRenameModal : Bool
    
    
    
    var body: some View {
        
        
        Button {
            print("rename")
            showRenameModal = true
        } label: {
            HStack(spacing: 5) {
                // button name
                Text("rename")
                    .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                    .fonzParagraphTwo()
                    .padding(.horizontal, 20)
                Spacer()
                Image("renameIcon").resizable()
                    .frame( width: 25, height: 25)
                    .padding(.horizontal, 20)
            }.padding(.vertical, 10)
        }
//        .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .lilac))
    }
}

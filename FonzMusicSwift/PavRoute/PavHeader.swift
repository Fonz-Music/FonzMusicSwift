//
//  PavHeader.swift
//  FonzMusicSwift
//
//  Created by didi on 10/25/21.
//

import SwiftUI

struct PavHeader: View {
    // checks if guest has a host
    @Binding var hasHostVar : Bool
    
    // gets dark/light mode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack{
            Text("The Pav")
                .foregroundColor(Color.white)
                .fonzParagraphOne()
                .padding(.leading, .headingFrontIndent)
                .padding(.trailing, 5)
            Text("- powered by Fonz")
                .foregroundColor(Color.white)
                .fonzParagraphThree()
                .padding(.vertical, .headingFrontIndent)
                .padding(.horizontal, 5)
            Spacer()
            Button {
                withAnimation {
                    hasHostVar = false
                }
            } label: {
                Image(systemName: "arrow.up.and.person.rectangle.portrait")
                    .resizable()
                    .frame(width: 20, height: 17, alignment: .center)
                    .foregroundColor(colorScheme == .light ? Color.gray: Color.white)
                
                    .padding(10)
                
            }
            .buttonStyle(BasicFonzButtonCircleNoBorder(bgColor: colorScheme == .light ? Color.white: Color.darkBackground, secondaryColor: .amber))
            .padding(.trailing, .headingFrontIndent)
        }.padding(.top, .headingTopIndent)
    }
}


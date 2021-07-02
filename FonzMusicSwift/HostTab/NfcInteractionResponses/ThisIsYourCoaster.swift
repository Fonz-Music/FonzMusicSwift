//
//  ThisIsYourCoaster.swift
//  FonzMusicSwift
//
//  Created by didi on 7/1/21.
//

import SwiftUI

struct ThisIsYourCoaster: View {
    var coasterName : String
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    
    var body: some View {
       
            VStack{
                Button(action: {
                }, label: {
                    Image("coasterIconLilac").resizable().frame(width: sideGraphicHeight * 1.1, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .frame(width: 125, height: 125)
                })
                    .buttonStyle(BasicFonzButtonCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .lilac))
                    .disabled(true)
                Text("this is your coaster")
                    .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                    .fonzRoundButtonText()
                Text("\(coasterName)")
                    .foregroundColor(.lilac)
                    .fonzParagraphOne()
                    .padding(5)
                
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: .cornerRadiusBlocks)
                    .fill(colorScheme == .light ? Color.white: Color.darkBackground)
                    .fonzShadow()
            )
    }
}


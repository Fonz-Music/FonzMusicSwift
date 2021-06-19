//
//  FailPartyJoin.swift
//  FonzMusicSwift
//
//  Created by didi on 6/16/21.
//

import SwiftUI

struct FailPartyJoin: View {
    
    let errorMessage:String
    let errorImage:String
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    
    var body: some View {
        VStack {
            ZStack{
                Circle()
                    .strokeBorder(Color.red, lineWidth: 3)
                    .background(Circle().foregroundColor(colorScheme == .light ? Color.white: Color.darkButton))
                    .frame(width: 125, height: 125)
                    .shadow(radius: 1)
                Image("\(errorImage)").resizable().frame(width: sideGraphicHeight, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
            Text("\(errorMessage)")
                .multilineTextAlignment(.center)
                .foregroundColor(.red)
                .fonzParagraphOne()
                .padding(5)
                .background(colorScheme == .light ? Color.clear: Color.black)
        }
    }
    
}


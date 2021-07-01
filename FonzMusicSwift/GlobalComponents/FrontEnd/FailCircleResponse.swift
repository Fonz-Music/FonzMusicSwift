//
//  FailPartyJoin.swift
//  FonzMusicSwift
//
//  Created by didi on 6/16/21.
//

import SwiftUI

struct FailCircleResponse: View {
//    @Binding var pressedButtonToLaunchNfc:Bool
    let errorMessage:String
    let errorImage:String
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    
    var body: some View {
        VStack {
            Button(action: {
//                withAnimation {
////                    pressedButtonToLaunchNfc = true
////                    selectedTab = 1
//                }
                
            }, label: {
                Image("\(errorImage)").resizable().frame(width: sideGraphicHeight, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .frame(width: 125, height: 125)
            })
            .buttonStyle(BasicFonzButtonCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .red))
            Text("\(errorMessage)")
                .multilineTextAlignment(.center)
                .foregroundColor(.red)
                .fonzParagraphOne()
                .padding(5)
                .background(colorScheme == .light ? Color.clear: Color.black)
            .disabled(true)
        }
    }
    
}


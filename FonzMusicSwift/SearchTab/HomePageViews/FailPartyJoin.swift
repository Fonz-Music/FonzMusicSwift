//
//  FailPartyJoin.swift
//  FonzMusicSwift
//
//  Created by didi on 6/16/21.
//

import SwiftUI

struct FailPartyJoin: View {
    @Binding var pressedButtonToLaunchNfc:Bool
    let errorMessage:String
    let errorImage:String
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    pressedButtonToLaunchNfc = true
//                    selectedTab = 1
                }
                
            }, label: {
                Image("\(errorImage)").resizable().frame(width: sideGraphicHeight, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .frame(width: 125, height: 125)
            })
            .buttonStyle(NeumorphicButtonStyleCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .red))
//            ZStack{
//                Circle()
//                    .strokeBorder(Color.red, lineWidth: 3)
//                    .background(Circle().foregroundColor(colorScheme == .light ? Color.white: Color.darkButton))
//                    .frame(width: 125, height: 125)
//                    .fonzShadow()
//                Image("\(errorImage)").resizable().frame(width: sideGraphicHeight, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                }
            Text("\(errorMessage)")
                .multilineTextAlignment(.center)
                .foregroundColor(.red)
                .fonzParagraphOne()
                .padding(5)
                .background(colorScheme == .light ? Color.clear: Color.black)
        }
    }
    
}

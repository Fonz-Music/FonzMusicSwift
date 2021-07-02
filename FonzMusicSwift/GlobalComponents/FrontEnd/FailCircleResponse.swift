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
                Image(systemName: "xmark")
                    .foregroundColor(.red)
                    .font(.system(size: 40))
                                        .frame(width: 125, height: 125)
            })
            .buttonStyle(BasicFonzButtonCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .red))
            Text("\(errorMessage)")
                .multilineTextAlignment(.center)
                .foregroundColor(.red)
                .fonzRoundButtonText()
                .padding(5)
                .background(colorScheme == .light ? Color.clear: Color.darkBackground)
            .disabled(true)
        }
    }
    
}


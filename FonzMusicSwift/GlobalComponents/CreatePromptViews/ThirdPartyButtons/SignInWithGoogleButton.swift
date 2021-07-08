//
//  SignInWithGoogleButton.swift
//  FonzMusicSwift
//
//  Created by didi on 7/8/21.
//

import SwiftUI

struct SignInWithGoogleButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack{
            Button {
//                            onSignUp = true
            } label: {
                Image("googleIconRainbow")
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
                    .padding()
//                                .foregroundColor(.white)
            }.buttonStyle(BasicFonzButtonCircleNoBorder(bgColor: colorScheme == .light ? Color.white: Color.black, secondaryColor: colorScheme == .light ? Color.black: Color.white))
            .padding(5)
        }
    }
}

struct SignInWithGoogleButton_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithGoogleButton()
    }
}

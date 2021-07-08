//
//  SignInWithAppleButton.swift
//  FonzMusicSwift
//
//  Created by didi on 7/8/21.
//

import SwiftUI

struct SignInWithAppleButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack{
            Button {
//                            onSignUp = true
            } label: {
                Image(systemName: "applelogo")
                    .frame(width: 25, height: 25, alignment: .center)
                    .foregroundColor(colorScheme == .light ? Color.white: Color.black)
                    .padding()
            }.buttonStyle(BasicFonzButtonCircleNoBorder(bgColor: colorScheme == .light ? Color.black: Color.white, secondaryColor: colorScheme == .light ? Color.white: Color.black))
            .padding(5)
        }
    }
}

struct SignInWithAppleButton_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithAppleButton()
    }
}

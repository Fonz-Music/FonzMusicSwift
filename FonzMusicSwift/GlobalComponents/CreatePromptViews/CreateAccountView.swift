//
//  CreateAccountView.swift
//  FonzMusicSwift
//
//  Created by didi on 7/9/21.
//

import SwiftUI

struct CreateAccountView: View {
    
    // bool that determines if the user has an account
    @Binding var hasAccount : Bool
    // so you can dismiss modal
    @Binding var showModal : Bool
    
    @State var onSignUp : Bool = true
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button {
                    withAnimation {
                        onSignUp = false
                    }
                    
                } label: {
                    Text("sign in")
                        .addUnderline(active: !onSignUp, color: .amber)
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzParagraphTwo()
                        .padding(.horizontal)
                    
                }
                Button {
                    withAnimation {
                        onSignUp = true
                    }
                } label: {
                    Text("sign up")
                        .addUnderline(active: onSignUp, color: .amber)
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzParagraphTwo()
                        .padding(.horizontal)
                    
                }
                Spacer()
            }
            .padding()
            if onSignUp {
                SignUpView(hasAccount: $hasAccount, showModal: $showModal).padding(.horizontal, 30)
            }
            else {
                SignInView(hasAccount: $hasAccount, showModal: $showModal).padding(.horizontal, 30)
            }
        }
    }
}
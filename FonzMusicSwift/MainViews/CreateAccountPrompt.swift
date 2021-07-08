//
//  CreateAccountPrompt.swift
//  FonzMusicSwift
//
//  Created by didi on 6/30/21.
//

import SwiftUI

struct CreateAccountPrompt: View {
    
    @State var onSignUp : Bool = true
    
    @Environment(\.colorScheme) var colorScheme
    
    
//    @State var acceptedPrivacy = false
//    @State var acceptedEmail = false
//
//    @State var displayName: String = ""
//    @State var email: String = ""
//    @State var password: String = ""
    
    
    var body: some View {
        ZStack{
            
        
            VStack{
                Spacer()
                    .frame(height: 50)
                Image("logoGradiant").resizable()
                    .frame(width: 35, height: 75)
                    .padding(.bottom)
                HStack{
                    Spacer()
                    Button {
                        onSignUp = false
                    } label: {
                        Text("sign in")
                            .addUnderline(active: !onSignUp, color: .amber)
                            .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                            .fonzParagraphTwo()
                            .padding(.horizontal)
                        
                    }
                    Button {
                        onSignUp = true
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
                    SignUpView().padding(.horizontal, 30)
                }
                else {
                    SignInView().padding(.horizontal, 30)
                }
                
                
                Spacer()
            }
            .background(
                Color(UIColor(colorScheme == .light ? Color.white: Color.darkBackground))
            )
            .ignoresSafeArea()
        }
    }
}

struct CheckBoxView: View {
    @Binding var checked: Bool
    
    var bgColor: Color
    var secondaryColor: Color

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? secondaryColor : bgColor)
//            .overlay(
//                Rectangle().stroke(secondaryColor, lineWidth: 3)
//            )
            .onTapGesture {
                self.checked.toggle()
            }
            
    }
}

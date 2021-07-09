//
//  CreateAccountPrompt.swift
//  FonzMusicSwift
//
//  Created by didi on 6/30/21.
//

import SwiftUI

struct CreateAccountPrompt: View {
    
    // bool that determines if the user has an account
    @Binding var hasAccount : Bool
    // so you can dismiss modal
    @Binding var showModal : Bool
    
//    @State var onSignUp : Bool = true
    
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
                
                // shows sign in or sign up
                CreateAccountView(hasAccount: $hasAccount, showModal: $showModal)
                
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

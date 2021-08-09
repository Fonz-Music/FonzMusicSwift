//
//  CreateAccountView.swift
//  FonzMusicSwift
//
//  Created by didi on 7/9/21.
//

import SwiftUI

struct CreateAccountView: View {
    
//    // bool that determines if the user has an account
//    @Binding var hasAccount : Bool
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    // so you can dismiss modal
    @Binding var showModal : Bool
    
    
    
    @State var onSignUp : Bool = true
    @State var email : String = UserDefaults.standard.string(forKey: "spotifyEmail") ?? ""
    @State var displayName : String = UserDefaults.standard.string(forKey: "spotifyDisplayName") ?? ""
    @State var password : String = ""
    
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
                        .foregroundColor(Color.white)
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
                        .foregroundColor(Color.white)
                        .fonzParagraphTwo()
                        .padding(.horizontal)
                    
                }
                Spacer()
            }
            .padding()
            if onSignUp {
                SignUpView(userAttributes: userAttributes, showModal: $showModal, displayName: $displayName, email: $email, password: $password).padding(.horizontal, 30)
            }
            else {
                SignInView(userAttributes: userAttributes, showModal: $showModal, email: $email, password: $password).padding(.horizontal, 30)
            }
        }
        
    }
}

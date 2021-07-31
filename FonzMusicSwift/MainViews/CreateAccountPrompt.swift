//
//  CreateAccountPrompt.swift
//  FonzMusicSwift
//
//  Created by didi on 6/30/21.
//

import SwiftUI

struct CreateAccountPrompt: View {
    
    // bool that determines if the user has an account
//    @Binding var hasAccount : Bool
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    // so you can dismiss modal
    @Binding var showModal : Bool
    
    var hadPreviousAccount : Bool?
    
    @State var throwPopupMakeNewAccount : Bool = false
    
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
                
                ScrollView{
                    // shows sign in or sign up
                    CreateAccountView(userAttributes: userAttributes, showModal: $showModal)
                        .padding(.bottom, 30)
                }
                
                
                Spacer()
            }
            .alert(isPresented: $throwPopupMakeNewAccount, content: {
                Alert(title: Text("You'll have to make a new account"), message: Text("Due to changes on the backend, you'll need to create a new account, connect to Spotify, & add your coasters again"), dismissButton: .default(Text("Got it")))
            })
//            .popover(isPresented: $throwPopupMakeNewAccount) {
//                Text("you'll have to make a new account")
//            }
            .onAppear {
                throwPopupMakeNewAccount = hadPreviousAccount ?? false
            }
            .background(
                ZStack{
                    Color(UIColor(Color.darkBackground))
                    VStack{
                        Spacer()
                        Image("peoplePartyingBackdrop")
                            .opacity(0.4)
                            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                    }
                }, alignment: .bottom)
           
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

//
//  SignUpView.swift
//  FonzMusicSwift
//
//  Created by didi on 7/8/21.
//

import SwiftUI

struct SignUpView: View {
    
    // bool that determines if the user has an account
//    @Binding var hasAccount : Bool
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    // so you can dismiss modal
    @Binding var showModal : Bool
   
    @State var acceptedPrivacy = false
    @State var acceptedEmail = false
    
    @State var displayName: String = ""
    @Binding var email: String
    @Binding var password: String 
    @State var confirmPassword: String = ""
    
    @State var errorOnPage: Bool = false
    @State var errorMessage : String = ""
    
    @Environment(\.colorScheme) var colorScheme
    
    func determineIfSignUpButtonDisable() -> Bool {
        if (acceptedPrivacy &&
            displayName != "" &&
                email.isValidEmail &&
            password != "" &&
            password == confirmPassword) {
            return false
        }
        else {
            return true
        }
    }
    
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    // username
                    TextField("", text: $displayName)
                        .placeholder(when: displayName.isEmpty, placeholder: {
                            Text("name")
                                .foregroundColor(.gray)
                                .fonzButtonText()
                        })
//                        .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                        .foregroundColor(.darkButton)
                        .fonzButtonText()
                        .padding(10)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: .cornerRadiusTasks)
//                                    .fill(colorScheme == .light ? Color.white : Color.darkButton )
                                    .fill(Color.white)
                                    .fonzShadow()
                                // is red if not entered
                                if (displayName == "" && acceptedPrivacy) {
                                    RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                                        .fill(Color.red)
                                        .opacity(0.40)
                                }
                            }
                       
                        )
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 5)
                    // email
                    TextField("", text: $email)
                        .placeholder(when: email.isEmpty, placeholder: {
                            Text("email")
                                .foregroundColor(.gray)
                                .fonzButtonText()
                        })
                        .keyboardType(.emailAddress)
//                        .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                        .foregroundColor(.darkButton)
                        .fonzButtonText()
                        .padding(10)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: .cornerRadiusTasks)
//                                    .fill(colorScheme == .light ? Color.white : Color.darkButton )
                                    .fill(Color.white)
                                    .fonzShadow()
                                // is red if not entered or not valid email
                                if ((email == "" || !email.isValidEmail) && acceptedPrivacy) {
                                    RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                                        .fill(Color.red)
                                        .opacity(0.40)
                                }
                            }
                        )
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 5)
                    // password
                    SecureField("", text: $password)
                        .placeholder(when: password.isEmpty, placeholder: {
                            Text("password")
                                .foregroundColor(.gray)
                                .fonzButtonText()
                        })
//                        .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                        .foregroundColor(.darkButton)
                        .fonzButtonText()
                        .padding(10)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: .cornerRadiusTasks)
//                                    .fill(colorScheme == .light ? Color.white : Color.darkButton )
                                    .fill(Color.white)
                                    .fonzShadow()
                                // is red if not entered or not equal to confirm
                                if ((password == "" || password != confirmPassword) && acceptedPrivacy) {
                                    RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                                        .fill(Color.red)
                                        .opacity(0.40)
                                }
                            }
                        )
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 5)
                    // confirm password
                    SecureField("", text: $confirmPassword)
                        .placeholder(when: confirmPassword.isEmpty, placeholder: {
                            Text("confirm password")
                                .foregroundColor(.gray)
                                .fonzButtonText()
                        })
//                        .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                        .foregroundColor(.darkButton)
                        .fonzButtonText()
                        .padding(10)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: .cornerRadiusTasks)
//                                    .fill(colorScheme == .light ? Color.white : Color.darkButton )
                                    .fill(Color.white)
                                    .fonzShadow()
                                // is red if not entered or not equal to confirm
                                if ((confirmPassword == "" || password != confirmPassword) && acceptedPrivacy) {
                                    RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                                        .fill(Color.red)
                                        .opacity(0.40)
                                }
                            }
                        )
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 5)
                    if errorOnPage {
                        Text("\(errorMessage)")
                            .foregroundColor(.red)
                            .fonzParagraphTwo()
                            .padding(.vertical, 5)
                    }
                }
                .animation(.spring())
//                Text("or")
////                    .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
//                                    .foregroundColor(Color.white)
//                    .fonzParagraphTwo()
//                    .padding(.vertical, 5)
//                // other sign in options
//                HStack {
//                    Spacer()
//                    // apple button
//                    SignInWithAppleButton()
//                    // google button
//                    SignInWithGoogleButton()
//                    Spacer()
//                }
                // terms
                VStack {
                    ConsentedToEmail(acceptedEmail: $acceptedEmail)
                        .padding(5)
                    ConsentedToPrivacy(acceptedPrivacy: $acceptedPrivacy)
                        .padding(5)
                }
                .animation(.spring())
                // sign up button
                Button {
                    
//                    let registerUserResp : BasicResponse = SignInSignUpApi().registerUser(email: email, password: password)
                    let registerUserResp : BasicResponse = UserApi().updateUserAccount(email: email, password: password, displayName: displayName, agreedConsent: acceptedPrivacy, agreedMarketing: acceptedEmail)
                    DispatchQueue.main.async {
                        if registerUserResp.status == 200 {
                            print("success")
                            userAttributes.setHasAccount(bool: true)
                            self.showModal.toggle()
                        }
//                        else if registerUserResp.status == 401 {
//
//                        }
                        else {
                            errorOnPage = true
                            errorMessage = registerUserResp.message ?? "something went wrong"
                            print("something went wrong")
                        }
                    }
                } label: {
                    Text("sign up")
                        .foregroundColor(Color.white)
                        .fonzParagraphTwo()
                        .frame(width: UIScreen.screenWidth * 0.8, height: 40, alignment: .center)
    //                    .padding(40)
                }
                .buttonStyle(BasicFonzButton(bgColor: .amber, secondaryColor: colorScheme == .light ? Color.white: Color.darkButton))
                .disabled(determineIfSignUpButtonDisable())
                .addOpacity(determineIfSignUpButtonDisable())
                .padding(.top)
            }
        }
    }
}

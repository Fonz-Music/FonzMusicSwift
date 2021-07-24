//
//  SignUpView.swift
//  FonzMusicSwift
//
//  Created by didi on 7/8/21.
//

import SwiftUI

struct SignUpView: View {
    
    // bool that determines if the user has an account
    @Binding var hasAccount : Bool
    // so you can dismiss modal
    @Binding var showModal : Bool
   
    @State var acceptedPrivacy = false
    @State var acceptedEmail = false
    
    @State var displayName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    @State var errorOnPage: Bool = false
    @State var errorMessage : String = ""
    
    @Environment(\.colorScheme) var colorScheme
    
    func determineIfSignUpButtonDisable() -> Bool {
        if (acceptedPrivacy &&
            acceptedEmail &&
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
                    TextField("display name", text: $displayName)
                        .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                        .fonzButtonText()
                        .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                        .padding(10)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                                    .fill(colorScheme == .light ? Color.white : Color.darkButton )
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
                    TextField("email", text: $email)
                        .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                        .fonzButtonText()
                        .padding(10)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                                    .fill(colorScheme == .light ? Color.white : Color.darkButton )
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
                    SecureField("password", text: $password)
                        .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                        .fonzButtonText()
                        .padding(10)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                                    .fill(colorScheme == .light ? Color.white : Color.darkButton )
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
                    SecureField("confirm password", text: $confirmPassword)
                        .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                        .fonzButtonText()
                        .padding(10)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                                    .fill(colorScheme == .light ? Color.white : Color.darkButton )
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
//                    .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
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
                    
                    let registerUserResp : BasicResponse = SignInSignUpApi().registerUser(email: email, password: password)
                    DispatchQueue.main.async {
                        if registerUserResp.status == 200 {
                            print("success")
                            hasAccount = true
                            UserDefaults.standard.set(true, forKey: "hasAccount")
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

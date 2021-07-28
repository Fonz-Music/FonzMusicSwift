//
//  SignInView.swift
//  FonzMusicSwift
//
//  Created by didi on 7/8/21.
//

import SwiftUI



struct SignInView: View {
    
    // bool that determines if the user has an account
    @Binding var hasAccount : Bool
    // so you can dismiss modal
    @Binding var showModal : Bool
    
    @Binding var email: String
    @Binding var password: String 
    
    @State var errorOnPage: Bool = false
    @State var errorMessage : String = ""
    
    @Environment(\.colorScheme) var colorScheme
    
    func determineIfSignInButtonDisable() -> Bool {
        if (email.isValidEmail &&
            password != "") {
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
                    // email
                    TextField("", text: $email)
                        .placeholder(when: email.isEmpty, placeholder: {
                            Text("email")
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
                                // is red if not entered or not valid email
                                if ((email == "" || !email.isValidEmail) && password != "") {
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
                Button {
                    // link to forgot password
                    
                } label: {
                    Text("forgot password?")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzButtonText()
                        .padding(.vertical, 10)
                }
                // sign in button
                Button {
                    let registerUserResp : BasicResponse = SignInSignUpApi().loginUser(email: email, password: password)
                    DispatchQueue.main.async {
                        if registerUserResp.status == 200 {
                            print("success")
                            withAnimation {
                                hasAccount = true
                            }
                            
                            UserDefaults.standard.set(true, forKey: "hasAccount")
                            self.showModal.toggle()
                        }
//                        else if registerUserResp.status == 401 {
//
//                        }
                        else {
                            errorOnPage = true
                            errorMessage = registerUserResp.message
                            if (registerUserResp.message == "") {
                                errorMessage = "something went wrong"
                            }
                            print("something went wrong")
                        }
                    }
                } label: {
                    Text("sign in")
                        .foregroundColor(Color.white)
                        .fonzParagraphTwo()
                        .frame(width: UIScreen.screenWidth * 0.8, height: 40, alignment: .center)
    //                    .padding(40)
                }
                .buttonStyle(BasicFonzButton(bgColor: .amber, secondaryColor: colorScheme == .light ? Color.white: Color.darkButton))
                .disabled(determineIfSignInButtonDisable())
                .addOpacity(determineIfSignInButtonDisable())
                .padding(.vertical)
            }
        }
    }
}

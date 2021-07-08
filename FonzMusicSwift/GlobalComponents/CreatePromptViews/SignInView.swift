//
//  SignInView.swift
//  FonzMusicSwift
//
//  Created by didi on 7/8/21.
//

import SwiftUI



struct SignInView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    
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
                    SecureField("password", text: $password)
                        .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                        .fonzButtonText()
                        .padding(10)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                                    .fill(colorScheme == .light ? Color.white : Color.darkButton )
                                    .fonzShadow()
                            
                                
                            }
                        )
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 5)
                }
                
                
                Text("or")
                    .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                    .fonzParagraphTwo()
                    .padding(.vertical, 5)
                // other sign in options
                HStack {
                    Spacer()
                    // apple button
                    SignInWithAppleButton()
                    // google button
                    SignInWithGoogleButton()
                    Spacer()
                }

                Button {
                    //
                } label: {
                    Text("forgot password?")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzButtonText()
                        .padding(.vertical, 10)
                }
                // sign in button
                Button {
                    
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

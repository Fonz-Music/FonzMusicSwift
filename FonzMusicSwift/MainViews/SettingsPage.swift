//
//  SettingsPage.swift
//  FonzMusicSwift
//
//  Created by didi on 6/14/21.
//

import SwiftUI

struct SettingsPage: View {
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.04
    
    var body: some View {
        ZStack{
            
            VStack{
                HStack{
                    Text("settings")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white).fonzParagraphOne()
                        .padding(25)
                        .padding(.top, 40)
                        .padding(.bottom, 20)
                    Spacer()
                }
                
   
                
                Button(action: {
//                    pressedButtonToLaunchNfc = true
                    print("pressed button")
                }, label: {
                    HStack {
                        HStack(spacing: 5) {
                            Image("changeNameIcon").resizable().frame(width: 27 ,height: 27, alignment: .leading)
                                
                            Text("change your name")
                                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                                .fonzParagraphTwo()
                                .padding(.horizontal)
                        }
                        Spacer()
                    }
                    .frame(width: UIScreen.screenWidth * 0.8, height: 20)
                    .padding()
                    
                })
            
                .buttonStyle(NeumorphicButtonStyle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
                Button(action: {
//                    pressedButtonToLaunchNfc = true
                    print("pressed button")
                }, label: {
                    HStack {
                        HStack(spacing: 5) {
                            Image("coasterIconAmber").resizable().frame(width: 30 ,height: 30, alignment: .leading)
                                
                            Text("buy a coaster")
                                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                                .fonzParagraphTwo()
                                .padding(.horizontal)                        }
                        Spacer()
                    }.frame(width: UIScreen.screenWidth * 0.8, height: 20)
                    .padding()
                    
                })
                
                .buttonStyle(NeumorphicButtonStyle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
                Button(action: {
//                    pressedButtonToLaunchNfc = true
                    print("pressed button")
                }, label: {
                    HStack {
                        HStack(spacing: 5) {
                            Image("spotifyIconAmber").resizable().frame(width: 30 ,height: 30, alignment: .leading)
                                
                            Text("spotify account")
                                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                                .fonzParagraphTwo()
                                .padding(.horizontal)
                        }
                        Spacer()
                    }.frame(width: UIScreen.screenWidth * 0.8, height: 20)
                    .padding()
                    
                }).buttonStyle(NeumorphicButtonStyle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
                
                Button(action: {
//                    pressedButtonToLaunchNfc = true
                    print("pressed button")
                }, label: {
                    HStack {
                        HStack(spacing: 5) {
                            Image("signOutIcon").resizable().frame(width: 30 ,height: 30, alignment: .leading)
                                
                            Text("sign out")
                                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                                .fonzParagraphTwo()
                                .padding(.horizontal)
                        }
                        Spacer()
                    }.frame(width: UIScreen.screenWidth * 0.8, height: 20)
                    .padding()
                    
                }).buttonStyle(NeumorphicButtonStyle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill( colorScheme == .light ? Color.white: Color.darkButton)
                    VStack(spacing: 10){
                        Text("how many song requests can your guests make?").multilineTextAlignment(.center)
                            .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                            .fonzParagraphTwo()
                        
                        HStack(spacing: 5){
                           
                            Button(action: {
                                
                            }, label: {
                                VStack {
                                    Text("a few").fonzAmberButtonText()
                                    Image("aFewIcon").resizable().frame(width: 30 ,height: 20)
                                }.frame(width: 60, height: 25)
                                .padding()
                            }).buttonStyle(NeumorphicButtonStyle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
                            
                            
                            Button(action: {
                                
                            }, label: {
                                VStack {
                                    Text("a lot").fonzAmberButtonText()
                                    Image("aLotIcon").resizable().frame(width: 30 ,height: 20)
                                }.frame(width: 60, height: 25)
                                .padding()
                            }).buttonStyle(NeumorphicButtonStyle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
                            
                            Button(action: {
                                
                            }, label: {
                                
                                VStack {
                                    Text("unlimited").fonzAmberButtonText()
                                    Image("unlimitedIcon").resizable().frame(width: 30 ,height: 20)
                                }.frame(width: 60, height: 25)
                                .padding()
                            }).buttonStyle(NeumorphicButtonStyle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber, selectedOption: true))
                            
                        }
                    }
                }.frame(width: UIScreen.screenWidth * 0.9, height: 150)
                
                Spacer()
            }
        }
        .background(
            Image("mountainProfile")
                .opacity(0.5)
                .frame(maxWidth: UIScreen.screenWidth), alignment: .bottom)
            
        .ignoresSafeArea()
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}

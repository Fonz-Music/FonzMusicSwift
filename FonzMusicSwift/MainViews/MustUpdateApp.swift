//
//  MustUpdateApp.swift
//  FonzMusicSwift
//
//  Created by didi on 6/30/21.
//

import SwiftUI

struct MustUpdateApp: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ZStack{
            
            VStack{
                HStack{
                    Text("Fonz Music")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white).fonzParagraphOne()
                        .padding(25)
                        .padding(.top, 40)
                        .padding(.bottom, 20)
                    Spacer()
                }
                Spacer()
                    .frame(height: 100)
                Text("you must update your app")
                    .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                    .font(Font.custom("MuseoSans-500", size: 32))
                    .multilineTextAlignment(.center)
//                    .fonzHeading()
                    .padding(25)
                Button(action: {
                    guard let url = URL(string: "https://apps.apple.com/us/app/fonz-music/id1537308329") else {
                        return
                    }
                    openURL(url)
                }, label: {
                    Text("take me there")
                        .foregroundColor(Color.white)
                        .fonzParagraphOne()
                        .padding(15)
                }).buttonStyle(BasicFonzButton(bgColor: .lilac, secondaryColor: colorScheme == .light ? Color.white: Color.darkButton))
                Spacer()
            }
        }
        .background(
            ZStack{
               
                Color(UIColor(colorScheme == .light ? Color.white: Color.darkBackground))
               
                Image("mountainProfile")
                    .opacity(0.4)
                    .frame(maxWidth: UIScreen.screenWidth)
            }, alignment: .bottom)
        .ignoresSafeArea()
    }
}

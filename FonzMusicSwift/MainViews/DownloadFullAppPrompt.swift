//
//  DownloadFullAppPrompt.swift
//  FonzMusicSwift
//
//  Created by didi on 7/18/21.
//

import SwiftUI

struct DownloadFullAppPrompt: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ZStack{
            
            VStack{
                HStack{
                    Text("Fonz Music")
                        .foregroundColor(.darkButton).fonzParagraphOne()
                        .padding(.headingFrontIndent)
                        .padding(.top, .headingTopIndent)
                        .padding(.bottom, 20)
                    Spacer()
                }
                Spacer()
                    .frame(height: 100)
                Text("download the full app to connect to Spotify")
                    .foregroundColor(.darkButton)
                    .font(Font.custom("MuseoSans-500", size: 32))
                    .multilineTextAlignment(.center)
//                    .fonzHeading()
                    .padding(.headingFrontIndent)
                Button(action: {
                    guard let url = URL(string: "https://apps.apple.com/us/app/fonz-music/id1537308329") else {
                        return
                    }
                    openURL(url)
                }, label: {
                    Text("take me there")
                        .foregroundColor(.white)
                        .fonzParagraphOne()
                        .padding(15)
                }).buttonStyle(BasicFonzButton(bgColor:  .darkButton, secondaryColor: .white))
                Spacer()
            }
        }
        .background(
            ZStack{
                Rectangle()
                    .fill(LinearGradient(
                        gradient: .init(colors: [.lilac, .lilacDark]),
                        startPoint: .topLeading,
                          endPoint: .bottomTrailing
                        ))
                    // darkens background when typing
//                    .darkenView(isEditingSearchBar)
                VStack{
                    Spacer()
                    Image("mountainProfile")
                        .opacity(0.4)
                        .frame(maxWidth: UIScreen.screenWidth)
                }
            }, alignment: .bottom)
        .ignoresSafeArea()
    }
    
}

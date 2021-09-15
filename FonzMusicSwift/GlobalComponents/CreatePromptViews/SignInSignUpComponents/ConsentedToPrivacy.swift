//
//  ConsentedToPrivacy.swift
//  FonzMusicSwift
//
//  Created by didi on 7/8/21.
//

import SwiftUI

struct ConsentedToPrivacy: View {
    
    @Binding var acceptedPrivacy : Bool
    @Environment(\.openURL) var openURL
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button {
            self.acceptedPrivacy.toggle()
        } label: {
            HStack{
                CheckBoxView(checked: $acceptedPrivacy, bgColor: Color.white, secondaryColor: .amber)
                HStack(spacing: 0){
                    Text("i accept Fonz's ")
    //                    .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                        .foregroundColor(Color.white)
                        .fonzParagraphThree()
                        .padding(.leading, 5)
                    Button(action: {
                        guard let url = URL(string: "https://fonzmusic.com/privacy-policy") else {
                            return
                        }
                        openURL(url)
                        print("pressed button")
                    }, label: {
                        Text("privacy policy")
        //                    .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                            .foregroundColor(.lilac)
                            .fonzParagraphThree()
                            .padding(.leading, 5)
                    })
                    Spacer()
                }
                
                
                Spacer()
            }
        }

        
    }
}

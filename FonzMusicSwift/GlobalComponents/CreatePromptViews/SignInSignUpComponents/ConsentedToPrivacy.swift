//
//  ConsentedToPrivacy.swift
//  FonzMusicSwift
//
//  Created by didi on 7/8/21.
//

import SwiftUI

struct ConsentedToPrivacy: View {
    
    @Binding var acceptedPrivacy : Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button {
            self.acceptedPrivacy.toggle()
        } label: {
            HStack{
                CheckBoxView(checked: $acceptedPrivacy, bgColor: Color.white, secondaryColor: .amber)
                Text("i accept Fonz's privacy policy")
//                    .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                    .foregroundColor(Color.white)
                    .fonzParagraphThree()
                    .padding(.leading, 5)
                Spacer()
            }
        }

        
    }
}

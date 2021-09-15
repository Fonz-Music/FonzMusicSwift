//
//  ConsentToEmail.swift
//  FonzMusicSwift
//
//  Created by didi on 7/8/21.
//

import SwiftUI

struct ConsentedToEmail: View {
    
    @Binding var acceptedEmail : Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button {
            self.acceptedEmail.toggle()
        } label: {
            HStack{
                CheckBoxView(checked: $acceptedEmail, bgColor: Color.white, secondaryColor: .amber)
                Text("i wanna receive email's from the Fonz Team")
//                    .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                    .foregroundColor(Color.white)
                    .fonzParagraphThree()
                    .padding(.leading, 5)
                Spacer()
            }
        }
    }
}

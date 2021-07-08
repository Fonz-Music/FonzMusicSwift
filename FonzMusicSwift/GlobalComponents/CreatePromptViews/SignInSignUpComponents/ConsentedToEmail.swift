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
                CheckBoxView(checked: $acceptedEmail, bgColor: colorScheme == .light ? Color.darkButton: Color.white, secondaryColor: .amber)
                Text("i accept Fonz's email policy")
                    .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                    .fonzParagraphThree()
                    .padding(.leading, 5)
                Spacer()
        }
        }

        
}
}

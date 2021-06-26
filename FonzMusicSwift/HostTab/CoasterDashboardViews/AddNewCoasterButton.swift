//
//  AddNewCoasterButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/25/21.
//

import SwiftUI

struct AddNewCoasterButton: View {
    
    @Binding var addNewCoasterPressed : Bool

    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button {
            print("pressed")
            withAnimation{
                addNewCoasterPressed = true
            }
            
        } label: {
            Image(systemName: "plus")
                .padding()
//                        Image("plusIconLilac")
        }
        .buttonStyle(CircleButtonGradiant(bgColorTopLeft: .lilac, bgColorBottomRight: .lilacDark, secondaryColor: Color.white))
        .padding(.bottom, 100)
        .padding(.top, 10)
    }
}

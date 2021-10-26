//
//  PavMenuHeader.swift
//  FonzMusicSwift
//
//  Created by didi on 10/26/21.
//

import SwiftUI

struct PavMenuHeader: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack{
            Image("pavPic")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .padding(10)
            Spacer()
            VStack {
                Button {
                    print("pressed drink")
                } label: {
                    Text("Drinks Menu")
                        .foregroundColor(.darkButton)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        .fonzParagraphOne()
                        .lineLimit(2)
                        .frame(width: 100)
                }
                
                .buttonStyle(BasicFonzButton(bgColor: .yellow, secondaryColor: .amber, selectedOption: true))
                .frame(width: 150)
                Button {
                    print("pressed food")
                } label: {
                    Text("Food Menu")
                        .foregroundColor(.darkButton)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        .fonzParagraphOne()
                        .lineLimit(2)
                        .frame(width: 100)
                }
               
                .buttonStyle(BasicFonzButton(bgColor: .yellow, secondaryColor: .amber, selectedOption: false))
                .frame(width: 150)
            }
            .padding()
            
        }
    }
}

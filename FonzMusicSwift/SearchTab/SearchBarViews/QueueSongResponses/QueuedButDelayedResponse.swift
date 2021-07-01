//
//  QueuedButDelayedResponse.swift
//  FonzMusicSwift
//
//  Created by didi on 7/1/21.
//

import SwiftUI

struct QueuedButDelayedResponse: View {


    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: {
        }, label: {
            HStack {
                HStack{
                    ZStack{
                        
                        Image(systemName: "minus")
                            .foregroundColor(.white)
                            .frame(width: 30 , height: 30, alignment: .center)
                    }.background(
                        RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                            .fill(Color.amber)
                            .frame(width: 60, height: 60)
                    )
                    .frame(width: 60, height: 60)
                    
                        
                    Text("queued but delayed. we'll add the song shortly")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzButtonText()
                        .padding(.horizontal, 5)
                    Spacer()
                }.padding(.vertical)
                
            }.frame(width: UIScreen.screenWidth * 0.9, height: 60)
            
            
        })
        .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber, selectedOption: true))
//        .padding()
        .disabled(true)
    }
}


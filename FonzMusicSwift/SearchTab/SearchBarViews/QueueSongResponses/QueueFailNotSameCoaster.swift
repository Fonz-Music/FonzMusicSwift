//
//  QueueFailNotSameCoaster.swift
//  FonzMusicSwift
//
//  Created by didi on 8/4/21.
//

import SwiftUI

struct QueueFailNotSameCoaster: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: {
        }, label: {
            HStack {
                HStack{
                    ZStack{
                        
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .frame(width: 30 , height: 30, alignment: .center)
                    }.background(
                        RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                            .fill(Color.red)
                            .frame(width: 60, height: 60)
                    )
                    .frame(width: 60, height: 60)
                    
                        
                    Text("you must tap the same coaster as before")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzButtonText()
                        .padding(.horizontal, 5)
                    Spacer()
                }.padding(.vertical)
                
            }.frame(width: UIScreen.screenWidth * 0.9, height: 60)
            
            
        })
        .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .red, selectedOption: true))
//        .padding()
        .disabled(true)
    }
}


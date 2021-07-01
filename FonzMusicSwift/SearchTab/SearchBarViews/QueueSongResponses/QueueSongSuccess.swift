//
//  QueueSongSuccess.swift
//  FonzMusicSwift
//
//  Created by didi on 7/1/21.
//

import SwiftUI

struct QueueSongSuccess: View {

    var songAddedName : String
    var currentHost : String

    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: {
        }, label: {
            HStack {
                HStack{
                    ZStack{
                        
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .frame(width: 30 , height: 30, alignment: .center)
                    }.background(
                        RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                            .fill(Color.successGreen)
                            .frame(width: 60, height: 60)
                    )
                    .frame(width: 60, height: 60)
                    
                        
                    Text("\(songAddedName) added to \(currentHost)'s queue!")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzButtonText()
                        .padding(.horizontal, 5)
                    Spacer()
                }.padding(.vertical)
                
            }.frame(width: UIScreen.screenWidth * 0.9, height: 60)
            
            
        })
        .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .successGreen, selectedOption: true))
//        .padding()
        .disabled(true)
    }
}


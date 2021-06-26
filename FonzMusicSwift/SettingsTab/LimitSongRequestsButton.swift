//
//  LimitSongRequestsButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/25/21.
//

import SwiftUI

struct LimitSongRequestsButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                .fill( colorScheme == .light ? Color.white: Color.darkButton)
            VStack(spacing: 10){
                Text("how many song requests can your guests make?").multilineTextAlignment(.center)
                    .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                    .fonzParagraphTwo()
                
                HStack(spacing: 5){
                   
                    Button(action: {
                        
                    }, label: {
                        VStack {
                            Text("a few").fonzAmberButtonText()
                            Image("aFewIcon").resizable().frame(width: 30 ,height: 20)
                        }.frame(width: 60, height: 25)
                        .padding()
                    })
                    
                    .buttonStyle(NeumorphicButtonStyle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
                    
                    
                    Button(action: {
                        
                    }, label: {
                        VStack {
                            Text("a lot").fonzAmberButtonText()
                            Image("aLotIcon").resizable().frame(width: 30 ,height: 20)
                        }.frame(width: 60, height: 25)
                        .padding()
                    }).buttonStyle(NeumorphicButtonStyle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
                    
                    Button(action: {
                        
                    }, label: {
                        
                        VStack {
                            Text("unlimited").fonzAmberButtonText()
                            Image("unlimitedIcon").resizable().frame(width: 30 ,height: 20)
                        }.frame(width: 60, height: 25)
                        .padding()
                    }).buttonStyle(NeumorphicButtonStyle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber, selectedOption: true))
                    
                }
            }
        }.frame(width: UIScreen.screenWidth * 0.9, height: 150)
    }
}

struct LimitSongRequestsButton_Previews: PreviewProvider {
    static var previews: some View {
        LimitSongRequestsButton()
    }
}

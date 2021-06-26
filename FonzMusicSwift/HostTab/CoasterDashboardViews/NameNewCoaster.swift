//
//  NameNewCoaster.swift
//  FonzMusicSwift
//
//  Created by didi on 6/25/21.
//

import SwiftUI

struct NameNewCoaster: View {
    
    @Binding var launchedNfc : Bool
   
    var coasterUid:String
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack{
           
                // coaster w lilac gradiant
                HStack{
                    // coaster bane
                    Image("coasterIconAlwaysWhite").resizable()
                        .frame( width: 35 ,height: 25).padding(.horizontal, 10)
                    Text("name your new coaster")
                        .foregroundColor(.white)
                        .fonzParagraphTwo()
                        .padding(.leading, 5)
                    Spacer()
                }
                .background(
                    RoundedRectangle(cornerRadius: 2)
                        .fill(LinearGradient(
                            gradient: .init(colors: [.lilac, Color.lilacDark]),
                            startPoint: .topLeading,
                              endPoint: .bottomTrailing
                            ))
                        .frame(height: 50)
                )
                .frame(height: 50)
                
                
                
            RenameCoasterField(showRenameModal: $launchedNfc, coasterUid: coasterUid)
            Spacer()
        }
        .frame(width: UIScreen.screenWidth * 0.8,height: 120)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(colorScheme == .light ? Color.white: Color.darkButton)
                .frame(height: 100)
                .shadow(color: Color.black.opacity(0.04), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 7)
        )
        .padding(.horizontal, 10)
        .animation(.easeIn)
    }
}

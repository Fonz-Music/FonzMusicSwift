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
    // list of coasters connected to the Host
    @ObservedObject var coastersConnectedToHost: CoastersFromApi
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    
    var body: some View {
        VStack{
           Spacer()
            Button(action: {
                // nothing
            }, label: {
                Image("coasterIcon").resizable().frame(width: sideGraphicHeight * 1.2, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .frame(width: 125, height: 125)
            })
            .buttonStyle(CircleButtonGradiant(bgColorTopLeft: .lilac, bgColorBottomRight: Color.lilacDark, secondaryColor: .white))
            .disabled(true)
            Text("let's name your coaster")
                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                .fonzRoundButtonText()
                
                
            RenameCoasterField(showRenameModal: $launchedNfc, coasterUid: coasterUid, coastersConnectedToHost: coastersConnectedToHost)
            Spacer()
        }
        .frame(width: UIScreen.screenWidth * 0.8, height: 250)
        .background(
            RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                .fill(colorScheme == .light ? Color.white: Color.darkButton)
//                .frame( )
                .fonzShadow()
        )
        .padding(.horizontal, 10)
        .animation(.easeIn)
    }
}

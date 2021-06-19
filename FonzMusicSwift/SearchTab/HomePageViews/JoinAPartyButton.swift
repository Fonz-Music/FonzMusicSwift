//
//  JoinAPartyButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/16/21.
//

import SwiftUI


struct JoinAPartyButton: View {
// ---------------------------------- created in view -----------------------------------------------

    @Binding var pressedButtonToLaunchNfc : Bool
    
    @Binding var showHomeButtons: Bool
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    
    @State var didTapButton = false;
    
    var body: some View {
        
        
        
        Button(action: {
            withAnimation {
                showHomeButtons = false
                pressedButtonToLaunchNfc = true
                didTapButton = true
            }
        }, label: {
            ZStack{
                if didTapButton {
                    Image("coasterIcon").resizable().frame(width: sideGraphicHeight, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .frame(width: 125, height: 125)
                }
                else {
                    Image("queueIcon").resizable().frame(width: sideGraphicHeight, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .frame(width: 125, height: 125)
                }
                
            }
        }).buttonStyle(NeumorphicButtonStyleCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .lilac))
        Text("i want to queue a song")
            .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
            .fonzParagraphTwo()
            
    }
    
}

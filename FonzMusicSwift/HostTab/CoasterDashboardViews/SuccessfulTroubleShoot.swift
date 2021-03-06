//
//  SuccessfulTroubleShoot.swift
//  FonzMusicSwift
//
//  Created by didi on 6/30/21.
//

import SwiftUI

//
//  JoinSuccessfulCircle.swift
//  FonzMusicSwift
//
//  Created by didi on 6/16/21.
//

import SwiftUI

struct SuccessFulTroubleShoot: View {
    
   
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.04
    
    var body: some View {
        VStack {
            ZStack{
                Circle()
                    .strokeBorder(Color.successGreen, lineWidth: 3)
                    .background(Circle().foregroundColor(colorScheme == .light ? Color.white: Color.darkButton))
                    .frame(width: 125, height: 125)
                    .fonzShadow()
                Image("checkIconGreen").resizable().frame(width: sideGraphicHeight, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
            Text("successfully troubleshooted")
                .multilineTextAlignment(.center)
                .foregroundColor(.successGreen)
                .fonzParagraphOne()
                .padding(5)
                .background(colorScheme == .light ? Color.clear: Color.black)
        }
    }
    
}

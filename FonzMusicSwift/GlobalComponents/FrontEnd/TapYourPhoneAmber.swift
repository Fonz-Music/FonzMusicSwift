//
//  TapYourPhoneAmber.swift
//  FonzMusicSwift
//
//  Created by didi on 6/30/21.
//

import SwiftUI

struct TapYourPhoneAmber: View {
    
    let tapCoasterWidth = UIScreen.screenHeight * 0.35
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 50)
            Text("tap your phone to the Fonz")
                .foregroundColor(.amber)
                .fonzParagraphOne()
            Image("tapCoasterIconAmber").resizable().frame(width: tapCoasterWidth, height: tapCoasterWidth * 0.75, alignment: .center)
        }
    }
}

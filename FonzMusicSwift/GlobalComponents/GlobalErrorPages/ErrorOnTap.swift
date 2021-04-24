//
//  ErrorOnTap.swift
//  Fonz Music App Clip
//
//  Created by didi on 2/12/21.
//

import SwiftUI

struct ErrorOnTap: View {
    let imageHeight = UIScreen.screenHeight * 0.09
    let boxHeight = UIScreen.screenHeight * 0.4
    let coasterHeight = UIScreen.screenHeight * 0.1
    
    var body: some View {
        ZStack {
//            Color(red: 168 / 255, green: 127 / 255, blue: 169 / 255).ignoresSafeArea()
            VStack{
                Spacer()
                Image("coasterIconWhite").resizable()
                    .frame(width: coasterHeight * 1.2, height: coasterHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                
                Text("uh oh").fonzHeading().padding()
                Text("the coaster didn't connect.").fonzParagraphOne()
                Text("give it another go").fonzParagraphOne()
                Spacer()
            }
        }
    }
}

struct ErrorOnTap_Previews: PreviewProvider {
    static var previews: some View {
        ErrorOnTap()
    }
}

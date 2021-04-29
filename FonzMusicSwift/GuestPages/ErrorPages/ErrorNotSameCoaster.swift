//
//  ErrorNotSameCoaster.swift
//  Fonz Music App Clip
//
//  Created by didi on 2/24/21.
//

import SwiftUI

struct ErrorNotSameCoaster: View {
    let imageHeight = UIScreen.screenHeight * 0.09
    let boxHeight = UIScreen.screenHeight * 0.4
    let coasterHeight = UIScreen.screenHeight * 0.1
    
    var body: some View {
        ZStack {
            Color(red: 168 / 255, green: 127 / 255, blue: 169 / 255).ignoresSafeArea()
            VStack{
                Spacer()
                Image("coasterIcon").resizable()
                    .frame(width: coasterHeight * 1.2, height: coasterHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                
                Text("what have you found?").fonzHeading().padding()
                Text("don't think this is the same coaster you scanned earlier").fonzParagraphOne()
                
                Spacer()
            }
        }
            }
}

struct ErrorNotSameCoaster_Previews: PreviewProvider {
    static var previews: some View {
        ErrorNotSameCoaster()
    }
}

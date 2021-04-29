//
//  deviceNotNfc.swift
//  Fonz Music App Clip
//
//  Created by didi on 3/1/21.
//

import SwiftUI

struct DeviceNotNfc: View {
    let imageHeight = UIScreen.screenHeight * 0.09
    let boxHeight = UIScreen.screenHeight * 0.4
    let coasterHeight = UIScreen.screenHeight * 0.1
    
    var body: some View {
        ZStack {
//            Color(red: 168 / 255, green: 127 / 255, blue: 169 / 255).ignoresSafeArea()
            VStack{
                Spacer()
                Image("coasterIcon").resizable()
                    .frame(width: coasterHeight * 1.2, height: coasterHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                
                Text("whatcha got there?").fonzHeading().padding()
                Text("we don't think your device supports tapping the coaster... :/").fonzParagraphOne()
               
                Spacer()
            }
        }
            }
}

struct DeviceNotNfc_Previews: PreviewProvider {
    static var previews: some View {
        DeviceNotNfc()
    }
}

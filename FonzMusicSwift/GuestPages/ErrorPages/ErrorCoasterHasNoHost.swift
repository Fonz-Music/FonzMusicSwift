//
//  ErrorCoasterHasNoHost.swift
//  Fonz Music App Clip
//
//  Created by didi on 3/8/21.
//

import SwiftUI

struct ErrorCoasterHasNoHost: View {
    let imageHeight = UIScreen.screenHeight * 0.09
    let boxHeight = UIScreen.screenHeight * 0.4
    let coasterHeight = UIScreen.screenHeight * 0.1
    
    var body: some View {
        ZStack {
            Color(red: 168 / 255, green: 127 / 255, blue: 169 / 255).ignoresSafeArea()
            VStack{
                Spacer()
                Image("coasterIconWhite").resizable()
                    .frame(width: coasterHeight * 1.2, height: coasterHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                
                Text("this coaster lacks a host").fonzHeading().padding()
                Text("download the full app to add this coaster to your account!").fonzParagraphOne()
                Spacer()
            }
            }
    }
}

struct ErrorCoasterHasNoHost_Previews: PreviewProvider {
    static var previews: some View {
        ErrorCoasterHasNoHost()
    }
}

//
//  ErrorQueuingSong.swift
//  Fonz Music App Clip
//
//  Created by didi on 2/12/21.
//

import SwiftUI

struct ErrorQueuingSong: View {
    let hostName:String
    
    let imageHeight = UIScreen.screenHeight * 0.09
    let boxHeight = UIScreen.screenHeight * 0.4
    let coasterHeight = UIScreen.screenHeight * 0.05
    
    var body: some View {
        ZStack {
            Color(red: 168 / 255, green: 127 / 255, blue: 169 / 255).ignoresSafeArea()
            VStack{
                Spacer()
                Image("rockOn").resizable()
                    .frame(width: imageHeight, height: imageHeight * 1.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)         
                Text("where's the music?").fonzHeading().padding(5)
                Text("ensure \(hostName) is actively playing music in the Spotify app.").fonzParagraphOne()
                
                Spacer()
            }
        }
            }
}

struct ErrorQueuingSong_Previews: PreviewProvider {
    static var previews: some View {
        ErrorQueuingSong(hostName: "david")
    }
}

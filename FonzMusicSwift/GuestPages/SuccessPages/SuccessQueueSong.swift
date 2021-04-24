//
//  SuccessQueueSong.swift
//  Fonz Music App Clip
//
//  Created by didi on 2/12/21.
//

import SwiftUI

struct SuccessQueueSong: View {
    let hostName:String

    
    let imageHeight = UIScreen.screenHeight * 0.15
    
    var body: some View {
                ZStack {
                    Color(red: 168 / 255, green: 127 / 255, blue: 169 / 255).ignoresSafeArea()
                    VStack{
                        Spacer()
                        Image("fonzLogoWhiteF").resizable()
                            .frame(width: imageHeight * 0.5, height: imageHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                        
                        Text("success!").fonzHeading().padding()
                        Text("added to \(hostName)'s queue").fonzParagraphOne()
                        
                        Spacer()
                    }
                }
            }
}

struct SuccessQueueSong_Previews: PreviewProvider {
    static var previews: some View {
        SuccessQueueSong(hostName: "david")
    }
}

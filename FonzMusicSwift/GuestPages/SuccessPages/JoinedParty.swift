//
//  JoinedParty.swift
//  Fonz Music App Clip
//
//  Created by didi on 2/12/21.
//

import SwiftUI

struct JoinedParty: View {
    let hostName:String
    let coasterName:String
    
    let imageHeight = UIScreen.screenHeight * 0.15
    
    var body: some View {
                ZStack {
                    Color.lilac.ignoresSafeArea()
//                    Color(red: 168 / 255, green: 127 / 255, blue: 169 / 255).ignoresSafeArea()
                    VStack{
                        Spacer()
                        Image("fonzLogoWhiteF").resizable()
                            .frame(width: imageHeight * 0.5, height: imageHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                        
                        Text("success!").fonzHeading().padding()
                        Text("joined \(hostName)'s party").fonzParagraphOne()
                        Text("with \(coasterName)").fonzParagraphOne()
                        Spacer()
                    }
                }
            }
}

struct JoinedParty_Previews: PreviewProvider {
    static var previews: some View {
        JoinedParty(hostName: "benji", coasterName: "meg")
    }
}

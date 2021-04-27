//
//  CoasterHasDifferentHost.swift
//  FonzMusicSwift
//
//  Created by didi on 4/27/21.
//

import SwiftUI

struct CoasterHasDifferentHost: View {
    let hostName:String
    let coasterName:String
    
    let imageHeight = UIScreen.screenHeight * 0.15
    
    var body: some View {
        ZStack {
            Color.amber.ignoresSafeArea()
            VStack{
                Spacer()
                Image("fonzLogoWhiteF").resizable()
                    .frame(width: imageHeight * 0.5, height: imageHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                
                Text("oops").fonzHeading().padding()
                Text("this is \(hostName)'s coaster").fonzParagraphOne()
                Text("named \(coasterName)").fonzSubheading().padding()
                Spacer()
            }
        }
    }
}

struct CoasterHasDifferentHost_Previews: PreviewProvider {
    static var previews: some View {
        CoasterHasDifferentHost(hostName: "tom", coasterName: "harry")
    }
}

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
    
    let imageHeight = UIScreen.screenHeight * 0.08
    
    var body: some View {
        ZStack {
            Color.amber.ignoresSafeArea()
            VStack{
                Spacer()
                Image("fonzLogoF").resizable()
                    .frame(width: imageHeight * 0.5, height: imageHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("this coaster belongs to").fonzParagraphOne()
                Text("\(hostName)").fonzHeading().padding(.vertical, 30)
                Text("and is named").fonzParagraphOne()
                Text("\(coasterName)").fonzHeading().padding(.vertical, 30)
                Spacer()
            }
        }
    }
}

struct CoasterHasDifferentHost_Previews: PreviewProvider {
    static var previews: some View {
        CoasterHasDifferentHost(hostName: "Erin", coasterName: "erins coaster")
    }
}

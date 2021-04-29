//
//  UsedAllQueues.swift
//  Fonz Music App Clip
//
//  Created by didi on 2/25/21.
//

import SwiftUI

struct UsedAllQueues: View {
    let imageHeight = UIScreen.screenHeight * 0.15
    var body: some View {
        ZStack {
            Color(red: 168 / 255, green: 127 / 255, blue: 169 / 255).ignoresSafeArea()
            VStack{
                Spacer()
                Text("uh oh").fonzHeading()
                Text("you'll need to download the full version to keep queuing").fonzParagraphOne()
                Image("queueIcon").resizable()
                    .frame(width: imageHeight, height: imageHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Text("don't worry, it's completely FREE").fonzParagraphOne()
                Spacer()
            }
            
        }
    }
}

struct UsedAllQueues_Previews: PreviewProvider {
    static var previews: some View {
        UsedAllQueues()
    }
}

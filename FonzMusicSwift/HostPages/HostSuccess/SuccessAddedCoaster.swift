//
//  SuccessAddedCoaster.swift
//  FonzMusicSwift
//
//  Created by didi on 4/27/21.
//

import SwiftUI

struct SuccessAddedCoaster: View {
    
    let imageHeight = UIScreen.screenHeight * 0.15
    
    var body: some View {
        ZStack {
            Color.amber.ignoresSafeArea()
//                    Color(red: 168 / 255, green: 127 / 255, blue: 169 / 255).ignoresSafeArea()
            VStack{
                Spacer()
                Image("fonzLogoWhiteF").resizable()
                    .frame(width: imageHeight * 0.5, height: imageHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                
                Text("success!").fonzHeading().padding()
                Text("you've now connected!").fonzParagraphOne()
                Spacer()
            }
        }
    }
}

struct SuccessAddedCoaster_Previews: PreviewProvider {
    static var previews: some View {
        SuccessAddedCoaster()
    }
}

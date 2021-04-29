//
//  ThisIsYourCoaster.swift
//  FonzMusicSwift
//
//  Created by didi on 4/27/21.
//

import SwiftUI

struct ThisIsYourCoaster: View {
    let coasterName:String
    
    let imageHeight = UIScreen.screenHeight * 0.15
    
    var body: some View {
                ZStack {
                    Color.lilac.ignoresSafeArea()
                    VStack{
                        Spacer()
                        Image("fonzLogoF").resizable()
                            .frame(width: imageHeight * 0.5, height: imageHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                        
                        
                        Text("this is your coaster").fonzParagraphOne()
                        Text("\(coasterName)").fonzHeading()
                        Spacer()
                    }
                }
            }
}

struct ThisIsYourCoaster_Previews: PreviewProvider {
    static var previews: some View {
        ThisIsYourCoaster(coasterName: "kenny guy")
    }
}

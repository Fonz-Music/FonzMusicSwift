//
//  HomePageDecision.swift
//  FonzMusicSwift
//
//  Created by didi on 6/15/21.
//

import SwiftUI

struct HomePageDecision: View {
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    
    var body: some View {
        
        ZStack{
            
            VStack{
                
                Text("search").foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white).fonzParagraphOne().padding()
                    .frame(width: UIScreen.screenWidth, height: 50, alignment: .topLeading)
                Spacer()
                Button(action: {}, label: {
                    ZStack{
                        Circle()
                            .strokeBorder(Color.amber, lineWidth: 3)
                            .background(Circle().foregroundColor(colorScheme == .light ? Color.white: Color.darkButton))
                            .frame(width: 125, height: 125)
                            .shadow(radius: 1)
                            
                            
                        Image("coasterIcon").resizable().frame(width: sideGraphicHeight * 1.2, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                })
                Text("i want to host a party").foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white).fonzParagraphTwo()
                Spacer()
                Button(action: {}, label: {
                    ZStack{
                        Circle()
                            
                            .strokeBorder(Color.lilac, lineWidth: 3)
                            .background(Circle().foregroundColor(colorScheme == .light ? Color.white: Color.darkButton))
                            .frame(width: 125, height: 125)
                            .shadow(radius: 1)
                        
                            
                        Image("queueIcon").resizable().frame(width: sideGraphicHeight, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                })
                Text("i want to queue a song").foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white).fonzParagraphTwo()
                Spacer()
                
            }
        }
        .background(Image("mountainProfile").frame(maxWidth: UIScreen.screenWidth), alignment: .bottom)
    }
}

struct HomePageDecision_Previews: PreviewProvider {
    static var previews: some View {
        HomePageDecision()
    }
}

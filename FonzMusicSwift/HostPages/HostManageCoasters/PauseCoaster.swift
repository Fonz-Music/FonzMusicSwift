//
//  PauseCoaster.swift
//  FonzMusicSwift
//
//  Created by didi on 4/29/21.
//

import SwiftUI

struct PauseCoaster: View {
    let coasterName:String
    let coasterUid:String
    let paused:Bool
    @Binding var isPresented:Bool
    let imageHeight = UIScreen.screenHeight * 0.1
    
    var body: some View {
        ZStack {
            Color.amber.ignoresSafeArea()
            VStack{
                Spacer()
                Image("fonzLogoF").resizable()
                    .frame(width: imageHeight * 0.5, height: imageHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                
                Text("are you sure you want to pause").fonzParagraphOne().padding()
                Spacer()
                Text("\(coasterName)").fonzHeading()
                Spacer()
                HStack {
                    Button(action: {
                        let HostApi = HostCoasterApi()
                        let resp = HostApi.pauseCoaster(coasterUid: coasterUid, paused: paused)
                        isPresented = false
                        print("pressed button")
                    }, label: {
                        Text("yes")
                            .fonzSubheading()
                    })
                    .buttonStyle(NeumorphicButtonStyle(bgColor: .amber))
                    .padding()
                    
                    Button(action: {
                        isPresented = false
                        print("pressed button")
                    }, label: {
                        Text("no")
                            .fonzSubheading()
                    })
                    .buttonStyle(NeumorphicButtonStyle(bgColor: .amber))
                    .padding()
                }
                
                Spacer()
            }
        }
    }
}

struct PauseCoaster_Previews: PreviewProvider {
    static var previews: some View {
//        PauseCoaster(coasterName: "charles")
        Text("hey")
    }
}

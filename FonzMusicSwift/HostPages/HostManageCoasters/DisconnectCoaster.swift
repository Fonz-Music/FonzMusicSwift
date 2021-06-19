//
//  DisconnectCoaster.swift
//  FonzMusicSwift
//
//  Created by didi on 4/29/21.
//

import SwiftUI

struct DisconnectCoaster: View {
    let coasterName:String
    let coasterUid:String
    @Binding var isPresented:Bool
    @ObservedObject var coasterFromSearch: CoastersFromApi
    let imageHeight = UIScreen.screenHeight * 0.1
    
    var body: some View {
        ZStack {
            Color.amber.ignoresSafeArea()
            VStack{
                Spacer()
                Image("fonzLogoF").resizable()
                    .frame(width: imageHeight * 0.5, height: imageHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                
                Text("are you sure you want to disconnect").fonzParagraphOne().padding()
                Spacer()
                Text("\(coasterName)").fonzHeading()
                Spacer()
                HStack {
                    Button(action: {
                       
                        let resp = HostCoasterApi().disconnectCoaster(coasterUid: coasterUid)
                        isPresented = false
                        coasterFromSearch.reloadCoasters()
                        print("pressed button")
                    }, label: {
                        Text("yes")
                            .fonzSubheading()
                    })
                    .buttonStyle(NeumorphicButtonStyle(bgColor: .amber, secondaryColor: .white))
                    .padding()
                    
                    Button(action: {
                        isPresented = false
                        print("pressed button")
                    }, label: {
                        Text("no")
                            .fonzSubheading()
                    })
                    .buttonStyle(NeumorphicButtonStyle(bgColor: .amber, secondaryColor: .white))
                    .padding()
                }
                
                Spacer()
            }
        }
    }
}

struct DisconnectCoaster_Previews: PreviewProvider {
    static var previews: some View {
//        DisconnectCoaster()
        Text("hey")
    }
}

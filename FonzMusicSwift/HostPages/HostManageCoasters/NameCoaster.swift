//
//  NameCoaster.swift
//  FonzMusicSwift
//
//  Created by didi on 4/29/21.
//

import SwiftUI

struct NameCoaster: View {
    @State var coasterName: String = ""
    var coasterUid:String
    @Binding var isPresented:Bool
    @ObservedObject var coasterFromSearch: CoastersFromApi
    let imageHeight = UIScreen.screenHeight * 0.10
    
    var body: some View {
        ZStack {
            Color.amber.ignoresSafeArea()
            VStack{
                Spacer()
                Image("fonzLogoF").resizable()
                    .frame(width: imageHeight * 0.5, height: imageHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                
                Text("let's name your coaster").fonzSubheading().padding()

                TextField("name", text: $coasterName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .border(Color(.systemGray5), width: 2)
//                    .foregroundColor(.systemGray5)
//                    .background(Color.amber)
                    .padding(.horizontal, UIScreen.screenWidth * 0.2)
                    .padding(.vertical, 20)
                    .fonzParagraphOne()
                    
                Spacer()
                Button {
                    print("pressed")
                    print("\(coasterName)")
                    let HostApi = HostCoasterApi()
                    let resp = HostApi.renameCoaster(coasterUid: coasterUid, newName: coasterName)
                    print("resp is \(resp)")
                    print("\(coasterName)")
                    isPresented = false
                    coasterFromSearch.reloadCoasters()
                } label: {
                    Text("enter").fonzSubheading()
                }.buttonStyle(NeumorphicButtonStyle(bgColor: .amber, secondaryColor: .white)).padding()

                
                Spacer()
            }
        }
    }
}

struct NameCoaster_Previews: PreviewProvider {
    static var previews: some View {
//        NameCoaster(coasterUid: "13215332121")
        Text("ugh")
    }
}

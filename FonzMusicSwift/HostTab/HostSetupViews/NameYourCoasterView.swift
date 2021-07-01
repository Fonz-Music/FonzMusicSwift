//
//  NameYourCoasterView.swift
//  FonzMusicSwift
//
//  Created by didi on 6/24/21.
//

import SwiftUI


struct NameYourCoasterView: View {
// ---------------------------------- created in view -----------------------------------------------

    @Binding var hasConnectedCoasters : Bool

    @State var coasterName: String = ""
    var coasterUid:String
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    
    var body: some View {
        VStack{
            Button(action: {
                // nothing
            }, label: {
                Image("coasterIcon").resizable().frame(width: sideGraphicHeight * 1.2, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .frame(width: 125, height: 125)
            })
            .buttonStyle(CircleButtonGradiant(bgColorTopLeft: .lilac, bgColorBottomRight: Color.lilacDark, secondaryColor: .white))
            .disabled(true)
            Text("let's name your coaster")
                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                .fonzRoundButtonText()
            TextField("name", text: $coasterName)
                .foregroundColor(colorScheme == .light ? Color.white : Color.darkBackground)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .fonzShadow()
                .padding(.horizontal, UIScreen.screenWidth * 0.18)
                .padding(.vertical, 10)
                .multilineTextAlignment(.center)
                .fonzParagraphTwo()
                
//            Spacer()
            Button {
                print("pressed")
                print("\(coasterName)")
                let HostApi = HostCoasterApi()
                let resp = HostApi.renameCoaster(coasterUid: coasterUid, newName: coasterName)
                print("resp is \(resp)")
                print("\(coasterName)")
                withAnimation {
                    hasConnectedCoasters = true
                }
            } label: {
                Text("continue")
                    .foregroundColor(Color.white)
                    .fonzParagraphTwo()
                    .frame(width: UIScreen.screenWidth * 0.5, height: 40, alignment: .center)
//                    .padding()
            }
            
            .buttonStyle(BasicFonzButton(bgColor: .lilac, secondaryColor: colorScheme == .light ? Color.white: Color.darkButton))
            
            
            Spacer()
        }
    }
}


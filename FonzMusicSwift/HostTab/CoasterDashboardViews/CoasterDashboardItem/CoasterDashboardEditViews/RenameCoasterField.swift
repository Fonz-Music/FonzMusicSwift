//
//  RenameCoasterField.swift
//  FonzMusicSwift
//
//  Created by didi on 6/25/21.
//

import SwiftUI
//import Firebase
import FirebaseAnalytics

struct RenameCoasterField: View {
    
    @Binding var showRenameModal : Bool
    
    @State var coasterName: String = ""
    var coasterUid:String
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack{
            TextField("name", text: $coasterName)
                .foregroundColor(colorScheme == .light ? Color.white : Color.darkButton)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .fonzShadow()
                .padding(10)
                .multilineTextAlignment(.leading)
                .fonzParagraphTwo()
            Button {
                print("\(coasterName)")
                let HostApi = HostCoasterApi()
                let resp = HostApi.renameCoaster(coasterUid: coasterUid, newName: coasterName)
                print("resp is \(resp)")
                print("\(coasterName)")
                withAnimation {
                    showRenameModal = false
                }
                FirebaseAnalytics.Analytics.logEvent("hostRenamedCoaster", parameters: ["user":"host", "tab":"host"])
            } label: {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .frame(width: 20 , height: 20, alignment: .center)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 15)
                
//                    .padding()
            }
            .frame(width: 80, height: 40, alignment: .center)
            .buttonStyle(BasicFonzButton(bgColor: .lilac, secondaryColor: colorScheme == .light ? Color.white: Color.darkButton))
            .padding(.vertical, 5)
        }
    }
}

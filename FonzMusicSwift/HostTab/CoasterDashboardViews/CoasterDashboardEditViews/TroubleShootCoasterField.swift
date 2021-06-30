//
//  TroubleShootCoasterField.swift
//  FonzMusicSwift
//
//  Created by didi on 6/25/21.
//

import SwiftUI
import Firebase

struct TroubleShootCoasterField: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var showTroubleShootModal : Bool
    var coasterUid:String
    
    var body: some View {
        VStack{
            // coaster bane
            Text("are you sure you want to troubleshoot this coaster?")
                .padding(.horizontal, 10)
                .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                .multilineTextAlignment(.center)
                .fonzParagraphTwo()
            HStack{
                Spacer()
                Button {
                   
                    withAnimation {
                        showTroubleShootModal = false
                    }
                    FirebaseAnalytics.Analytics.logEvent("hostTroubleShootedCoaster", parameters: ["user":"host", "tab":"host"])
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .frame(width: 20 , height: 20, alignment: .center)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                    
    //                    .padding()
                }
                .frame(width: 80, height: 40, alignment: .center)
                .buttonStyle(BasicFonzButton(bgColor: .lilac, secondaryColor: colorScheme == .light ? Color.white: Color.darkButton))
                .padding(.vertical, 5)
                Spacer()
                Button {
                    // read uid from coaster
                    // then write "domain" + uid
                    print("pressed button")
                    withAnimation {
                        showTroubleShootModal = false
                    }
                } label: {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .frame(width: 20 , height: 20, alignment: .center)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                    
    //                    .padding()
                }
                .frame(width: 80, height: 40, alignment: .center)
                .buttonStyle(BasicFonzButton(bgColor: .lilac, secondaryColor: colorScheme == .light ? Color.white: Color.darkButton))
                .padding(.vertical, 5)
                Spacer()
            }
        }
    }
}

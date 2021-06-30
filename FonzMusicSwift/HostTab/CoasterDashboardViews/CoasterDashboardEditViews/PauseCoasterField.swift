//
//  PauseCoasterField.swift
//  FonzMusicSwift
//
//  Created by didi on 6/25/21.
//

import SwiftUI
import Firebase

struct PauseCoasterField: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var showPauseModal : Bool
    var paused: Bool
    var coasterUid:String
    
    var body: some View {
        VStack{
            // coaster bane
            Text("are you sure you want to pause this coaster?")
                .padding(.horizontal, 10)
                .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                .multilineTextAlignment(.center)
                .fonzParagraphTwo()
            HStack{
                Spacer()
                Button {
                   
                    withAnimation {
                        showPauseModal = false
                    }
                    FirebaseAnalytics.Analytics.logEvent("hostPausedCoaster", parameters: ["user":"host", "tab":"host"])
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
                    print("paused is \(paused)")
                    let resp = HostCoasterApi().pauseCoaster(coasterUid: coasterUid, paused: paused)
//                    coasterFromSearch.reloadCoasters()
                    print("pressed button")
                    withAnimation {
                        showPauseModal = false
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

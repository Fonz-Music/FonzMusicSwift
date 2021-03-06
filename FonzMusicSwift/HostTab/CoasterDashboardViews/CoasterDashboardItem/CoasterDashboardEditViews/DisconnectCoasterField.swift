//
//  DisconnectCoasterField.swift
//  FonzMusicSwift
//
//  Created by didi on 6/25/21.
//

import SwiftUI
//import Firebase
import FirebaseAnalytics

struct DisconnectCoasterField: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var showDisconnectModal : Bool
    var coasterUid:String
    
    @ObservedObject var coastersConnectedToHost: CoastersFromApi
    
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    
    var body: some View {
        VStack{
            // coaster bane
            Text("are you sure you want to disconnect this coaster?")
                .padding(.horizontal, 10)
                .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                .multilineTextAlignment(.center)
                .fonzParagraphTwo()
            HStack{
                Spacer()
                Button {
                   
                    withAnimation {
                        showDisconnectModal = false
                    }
                    
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
                    let resp = HostCoastersApi().disconnectCoaster(coasterUid: coasterUid)
                    print("pressed button")
                    withAnimation {
                        showDisconnectModal = false
                        if coastersConnectedToHost.products.quantity == 1 {
                            // sets app to NOT have coasters if the user lacks them
                            userAttributes.setHasConnectedCoasters(bool: false)
                        }
                        coastersConnectedToHost.reloadCoasters()
                    
                    }
                    
                    FirebaseAnalytics.Analytics.logEvent("hostDisconnectedCoaster", parameters: ["user":"host", "tab":"host"])
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

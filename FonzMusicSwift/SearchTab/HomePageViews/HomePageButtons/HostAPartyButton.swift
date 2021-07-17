//
//  HostAPartyButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/16/21.
//

import SwiftUI
//import Firebase
import FirebaseAnalytics

struct HostAPartyButton: View {

    // inherited that indicated the tab the app is on
    @Binding var selectedTab: TabIdentifier
    
    @Binding var showHomeButtons: Bool
    // determines if current user has an account
    @Binding var hasAccount : Bool
    // has user create an account
    @State var throwCreateAccountModal = false
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.04
    
    var body: some View {
        VStack{
            Button(action: {
                
                
                if hasAccount {
                    withAnimation {
                        showHomeButtons = false
                    }
                    FirebaseAnalytics.Analytics.logEvent("userTappedSetupCoaster", parameters: ["user":"user", "tab":"search"])
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        withAnimation {
                            selectedTab = TabIdentifier.host
                            showHomeButtons = true
                        }
                    }
                }
                else {
                    throwCreateAccountModal = true
                }
                
                
                
            }, label: {
                Image("coasterIconLilac").resizable().frame(width: sideGraphicHeight * 1.1, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .frame(width: 75, height: 75)
            })
            .buttonStyle(BasicFonzButtonCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .lilac))
//            Text("i want to setup my coaster")
//                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
//                .fonzRoundButtonText()
            Text("setup my coaster")
                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                .fonzParagraphTwo()
        }
        .sheet(isPresented: $throwCreateAccountModal) {
            CreateAccountPrompt(hasAccount: $hasAccount, showModal: $throwCreateAccountModal)
        }
        
    }
    
}

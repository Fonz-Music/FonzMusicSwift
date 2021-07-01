//
//  CoasterDoesNotHaveHost.swift
//  FonzMusicSwift
//
//  Created by didi on 7/1/21.
//

import SwiftUI
import FirebaseAnalytics

struct CoasterDoesNotHaveHost: View {
    
    // inherited that indicated the tab the app is on
    @Binding var selectedTab: TabIdentifier
    // determines if current user has an account
    @Binding var hasAccount : Bool
    
    @Binding var showHomeButtons: Bool
    
    @Binding var launchedNfc: Bool
    
    // has user create an account
    @State var throwCreateAccountModal = false
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.04
    
    var body: some View {
        VStack {
            ZStack{
                Circle()
                    .strokeBorder(Color.lilac, lineWidth: 3)
                    .background(Circle().foregroundColor(colorScheme == .light ? Color.white: Color.darkButton))
                    .frame(width: 125, height: 125)
                    .fonzShadow()
                Image(systemName: "minus")
                    .foregroundColor(.lilac)
                    .font(.system(size: 40))

            }
            .padding()
            VStack{
                Text("this coaster doesn't have a host.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.lilac)
                    .fonzRoundButtonText()
                    .padding(5)
                Text("would you like to become the host?")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.lilac)
                    .fonzRoundButtonText()
                    .padding(5)
            }
            .background(colorScheme == .light ? Color.clear: Color.darkBackground)
            Button {
                
                if hasAccount {
                    withAnimation {
                        showHomeButtons = false
                    }
                    FirebaseAnalytics.Analytics.logEvent("userTriedJoiningPartyCoasterNoHost", parameters: ["user":"user", "tab":"search"])
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
                
                withAnimation {
                    launchedNfc = false
                }

            } label: {
                Text("connect")
                    .foregroundColor(Color.white)
                    .fonzParagraphTwo()
                    .frame(width: UIScreen.screenWidth * 0.5, height: 40, alignment: .center)
//                    .padding()
            }
            
            .buttonStyle(BasicFonzButton(bgColor: .lilac, secondaryColor: colorScheme == .light ? Color.white: Color.darkButton))
            .padding()
        }
        .sheet(isPresented: $throwCreateAccountModal) {
            CreateAccountPrompt()
        }
    }
}

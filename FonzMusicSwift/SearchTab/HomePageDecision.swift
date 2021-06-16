//
//  HomePageDecision.swift
//  FonzMusicSwift
//
//  Created by didi on 6/15/21.
//

import SwiftUI

struct HomePageDecision: View {
// ---------------------------------- inherited from parent -----------------------------------------
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    // inherited from parent and tells you if you have a host
    @Binding var hasHostVar:Bool
// ---------------------------------- created in view -----------------------------------------------
    // bool auto set to false, set to true if nfc is launched
    @State var launchedNfc = false
    // temp Coaster Object so that page does not update BEFORE showing success page
    @State var tempCoasterDetails = HostCoasterInfo()
    // local var that is returned by nfc prompt when getting host from API
    @State var statusCodeResp = 0
    
    @State var pressedButtonToLaunchNfc = false
    

    
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    
    @State var showHomeButtons = true
    @State var joinPartySuccess = false
    
    var body: some View {
        
        ZStack{
            
            VStack{
                
                Text("search")
                    .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                    .fonzParagraphOne()
                    .padding()
                    .frame(width: UIScreen.screenWidth, height: 50, alignment: .topLeading)
                    .padding(.top, 40)
                    
                Spacer()
                if !launchedNfc {
                    if showHomeButtons {
                        HostAPartyButton(showHomeButtons: $showHomeButtons)
                            Spacer()
                        JoinAPartyButton(pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc, showHomeButtons: $showHomeButtons)
                    }
                    if pressedButtonToLaunchNfc {
                        LaunchJoinPartyNfcSession(
                            tempCoaster: $tempCoasterDetails,
                            launchedNfc: $launchedNfc,
                            statusCode: $statusCodeResp,
                            pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc
                        ).frame(maxWidth: 0, maxHeight: 0, alignment: .center)
                    }
                }
                else {
                    // if guest joins properly
                    if statusCodeResp == 200 {
                        JoinSuccessfulCircle(hostName: tempCoasterDetails.hostName, coasterName: tempCoasterDetails.coasterName).animation(.easeIn)
                            .onAppear {
                                // waits 3.5 seconds before naviagiting to searchbar
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                                    print("firing now")
                                    withAnimation {
                                    // changes hostCoaster details to return to parent
                                    self.hostCoaster.coasterName = tempCoasterDetails.coasterName
                                    self.hostCoaster.hostName = tempCoasterDetails.hostName
                                    self.hostCoaster.sessionId = tempCoasterDetails.sessionId
                                    self.hostCoaster.uid = tempCoasterDetails.uid
                                        
                                    self.hasHostVar = true
                                    }
                                }
                            }
                    }
                    else {
                        
                        Button {
                            pressedButtonToLaunchNfc = true
                        } label: {
                            FailPartyJoin(errorMessage: "you did not join the party. press to try again", errorImage: "disableIcon")
                        }
                        if pressedButtonToLaunchNfc {
                            LaunchJoinPartyNfcSession(
                                tempCoaster: $tempCoasterDetails,
                                launchedNfc: $launchedNfc,
                                statusCode: $statusCodeResp,
                                pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc
                            ).frame(maxWidth: 0, maxHeight: 0, alignment: .center)
                        }

                    }
                }
                Spacer()
                
            }
        }
        .background(
            Image("mountainProfile")
                .opacity(0.5)
                .frame(maxWidth: UIScreen.screenWidth),
            alignment: .bottom)
        .ignoresSafeArea()
    }
    

}

struct HostAPartyButton: View {
    @Binding var showHomeButtons: Bool
    
    
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    
    var body: some View {
        Button(action: {
            withAnimation {
                showHomeButtons = false
            }
            
        }, label: {
            ZStack{
                Circle()
                    .strokeBorder(Color.amber, lineWidth: 3)
                    .background(Circle().foregroundColor(colorScheme == .light ? Color.white: Color.darkButton))
                    .frame(width: 125, height: 125)
                    .shadow(radius: 1)
                    
                    
                Image("coasterIcon").resizable().frame(width: sideGraphicHeight * 1.2, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        })
        Text("i want to host a party").foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white).fonzParagraphTwo()
    }
    
}
struct JoinAPartyButton: View {
// ---------------------------------- created in view -----------------------------------------------
//    // bool auto set to false, set to true if nfc is launched
//    @Binding var launchedNfc : Bool
//    // temp Coaster Object so that page does not update BEFORE showing success page
//    @Binding var tempCoasterDetails : HostCoasterInfo
//    // local var that is returned by nfc prompt when getting host from API
//    @Binding var statusCodeResp : Int
    // local var that when true, launches the nfc prompt. used for connectionErrors
    // or connect to a new host
    @Binding var pressedButtonToLaunchNfc : Bool
    
    @Binding var showHomeButtons: Bool
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    
    var body: some View {
        Button(action: {
            withAnimation {
                showHomeButtons = false
                pressedButtonToLaunchNfc = true
            }
        }, label: {
            ZStack{
                Circle()
                    .strokeBorder(Color.lilac, lineWidth: 3)
                    .background(Circle().foregroundColor(colorScheme == .light ? Color.white: Color.darkButton))
                    .frame(width: 125, height: 125)
                    .shadow(radius: 1)
                Image("queueIcon").resizable().frame(width: sideGraphicHeight, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
            }
        })
        Text("i want to queue a song").foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white).fonzParagraphTwo()
    }
    
}
struct JoinSuccessfulCircle: View {
    
    let hostName:String
    let coasterName:String
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    
    var body: some View {
        VStack {
            ZStack{
                Circle()
                    .strokeBorder(Color.successGreen, lineWidth: 3)
                    .background(Circle().foregroundColor(colorScheme == .light ? Color.white: Color.darkButton))
                    .frame(width: 125, height: 125)
                    .shadow(radius: 1)
                Image("queueIcon").resizable().frame(width: sideGraphicHeight, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
            Text("successfully connected to \(hostName)'s coaster \(coasterName)")
                .multilineTextAlignment(.center)
                .foregroundColor(.successGreen)
                .fonzParagraphOne()
        }
    }
    
}

struct FailPartyJoin: View {
    
    let errorMessage:String
    let errorImage:String
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    
    var body: some View {
        VStack {
            ZStack{
                Circle()
                    .strokeBorder(Color.red, lineWidth: 3)
                    .background(Circle().foregroundColor(colorScheme == .light ? Color.white: Color.darkButton))
                    .frame(width: 125, height: 125)
                    .shadow(radius: 1)
                Image("\(errorImage)").resizable().frame(width: sideGraphicHeight, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
            Text("\(errorMessage)")
                .multilineTextAlignment(.center)
                .foregroundColor(.red)
                .fonzParagraphOne()
        }
    }
    
}


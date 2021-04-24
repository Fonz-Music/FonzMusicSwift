//
//  JoinParty.swift
//  Fonz Music App Clip
//
//  Created by didi on 1/31/21.
//

import SwiftUI
import CoreNFC
import UIKit
import Firebase


struct JoinParty: View {
// ---------------------------------- inherited from parent -----------------------------------------
    // gets object to determine if the page should be updated
    @Binding var determineGuestViewUpdate: UpdatePageViewVariables
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    // inherited from parent and tells you if you have a host
    @Binding var hasHostVar:Bool
    // inherited from parent to see active page. so that nfc prompt does not launch when
    // app rebuilds on other pages
    @Binding var guestPageNumber:Int
// ---------------------------------- created in view -----------------------------------------------
    // bool auto set to false, set to true if nfc is launched
    @State var launchedNfc = false
    // bool auto set to false, set to true if coaster has a host
    @State var coasterHasHost = false
    // temp Coaster Object so that page does not update BEFORE showing success page
    @State var tempCoasterDetails = HostCoasterInfo()
    // local var that is returned by nfc prompt when getting host from API
    @State var statusCodeResp = 0
    // local var that when true, launches the nfc prompt. used for connectionErrors
    // or connect to a new host
    @State var pressedButtonToLaunchNfc = false
    // scaled height of icon
    let imageHeight = UIScreen.screenHeight * 0.15

    var body: some View {
        // checks to see if the device supports nfc
        if NFCNDEFReaderSession.readingAvailable {
        // if the user has not launched the nfc tap
            if !launchedNfc {
                // if the user already has a host, give optipn to connect again
                if guestHasHost(sessionId: hostCoaster.sessionId) && guestPageNumber == 0 {
                   ZStack {
                            Color(red: 168 / 255, green: 127 / 255, blue: 169 / 255).ignoresSafeArea()
                            VStack{
                                Spacer()
                                // displays view that says youre already connected
                                AlreadyJoinedAddNew(hostName: hostCoaster.hostName).padding(.top, 50)
                                    Spacer()
                                // button to connect to a new host
                                Button(action: {
                                    pressedButtonToLaunchNfc = true
                                    print("pressed button")
                                }, label: {
                                    Text("connect to a new host").fonzSubheading()
                                })
                                .buttonStyle(NeumorphicButtonStyle(bgColor: .lilac))
                                .padding(.top, 100)
                                .padding(.bottom, 50)
                                // if that button is pressed, the nfc is launched
                                if pressedButtonToLaunchNfc {
                                    ShowNfcTryAgainButton(tempCoaster: $tempCoasterDetails, launchedNfc: $launchedNfc, statusCode: $statusCodeResp, pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc).frame(maxWidth: 0, maxHeight: 0, alignment: .center)
                                }
                                // button to return you to searchbar if you dont want to connect to a new host
                                Button(action: {
                                    self.guestPageNumber = 1
                                }, label: {
                                    Image("Arrow Down White").resizable()
                                        .frame(width: imageHeight * 0.4, height: imageHeight * 0.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                }).padding()
                                Spacer()
                            }
                    }
                }
                // if the user has not joined a party yet (default), auto launch nfc prompt
                else {
                    ZStack {
                        Color(red: 168 / 255, green: 127 / 255, blue: 169 / 255).ignoresSafeArea()
                        VStack{
                            Text("tap the Fonz Coaster").fonzSubheading().padding(.top, 130)
//                            Image("tapOneWhite").resizable()
//                                .frame(width: imageHeight * 0.8, height: imageHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            // nfc prompt auto launches, shows tapIcon incase error on launch
                            LaunchJoinPartyNfcSession(tempCoaster: $tempCoasterDetails, launchedNfc: $launchedNfc, statusCode: $statusCodeResp, guestPageNumber: $guestPageNumber)
                                .padding(.bottom, 400)
                            Spacer()
                        }
                    }
                }
            }
            // if user has launched the nfc tap
            else {
                // if the guest connects to their host properly
                if statusCodeResp == 200 {
                    JoinedParty(hostName: tempCoasterDetails.hostName, coasterName: tempCoasterDetails.coasterName).onAppear {
                        // waits 3.5 seconds before naviagiting to searchbar
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            print("firing now")
                            // changes hostCoaster details to return to parent
                            self.hostCoaster.coasterName = tempCoasterDetails.coasterName
                            self.hostCoaster.hostName = tempCoasterDetails.hostName
                            self.hostCoaster.sessionId = tempCoasterDetails.sessionId
                            self.hostCoaster.uid = tempCoasterDetails.uid
                            // tells Pageview to update and WHAT page
                            self.guestPageNumber = 1
//                                self.hasHostVar = true
                        }
                    }
                }
                // if theres an issue connecting
                else {
                    ZStack {
                        Color(red: 168 / 255, green: 127 / 255, blue: 169 / 255).ignoresSafeArea()
                        VStack{
                            Spacer()
                            // if the coaster has no host
                            if (statusCodeResp == 204) {
                                ErrorCoasterHasNoHost().padding(.top, 40)
                            }
                            // if its not in our db
                            else if (statusCodeResp == 404 ) {
                                ErrorNotFonzCoaster().padding(.top, 40)
                            }
                            // any other error (usually nfc didnt work)
                            else {
                                ErrorOnTap().padding(.top, 40)
                            }
                            Spacer()
                            // button to launch nfc again
                            Button(action: {
                                pressedButtonToLaunchNfc = true
                                print("pressed button")
                            }, label: {
                                Text("connect again").fonzSubheading()
                            }).buttonStyle(NeumorphicButtonStyle(bgColor: .lilac)).padding(.vertical, 100)
                            // if they press the button, this launches the nfc prompt
                            if pressedButtonToLaunchNfc {
                                ShowNfcTryAgainButton(tempCoaster: $tempCoasterDetails, launchedNfc: $launchedNfc, statusCode: $statusCodeResp, pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc).frame(maxWidth: 0, maxHeight: 0, alignment: .center)
                                
                            }
//                            Spacer()
                        }
                    }
                }
            }
        }
        // if the device does not support nfc
        else {
            DeviceNotNfc()
        }
    }
    
    // simple function to determine if the guest is currently connected to a host. Used to either
    // display the auto nfc-prompt or view asking to connect to new host
    func guestHasHost(sessionId: String) -> Bool {
        var hasHost = true
        if (sessionId.isEmpty || sessionId == "") {
            hasHost = false
        }
        return hasHost
    }
}

struct JoinParty_Previews: PreviewProvider {
    static var previews: some View {
//        JoinParty(activepage: 0)
        Text("ugh")
    }
}

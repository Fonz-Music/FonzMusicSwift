//
//  HostAddCoaster.swift
//  FonzMusicSwift
//
//  Created by didi on 4/27/21.
//

import SwiftUI
import CoreNFC

struct HostAddCoaster: View {
// ---------------------------------- inherited from parent -----------------------------------------
    // gets object to determine if the page should be updated
    @Binding var determineHostViewUpdate: UpdatePageViewVariables
    // app rebuilds on other pages
    @Binding var hostPageNumber:Int
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
                
                ZStack {
                    Color.amber.ignoresSafeArea()
                    VStack{
                        Text("get coaster details").fonzSubheading().padding(.top, 130)
//                            Image("tapOneWhite").resizable()
//                                .frame(width: imageHeight * 0.8, height: imageHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        // nfc prompt auto launches, shows tapIcon incase error on launch
                        LaunchJoinPartyNfcSession(tempCoaster: $tempCoasterDetails, launchedNfc: $launchedNfc, statusCode: $statusCodeResp, guestPageNumber: $hostPageNumber)
                            .padding(.bottom, 400)
                        Spacer()
                    }
                    }
                
            }
            // if user has launched the nfc tap
            else {
                // if the guest connects to their host properly
                if statusCodeResp == 204 {
                    SuccessAddedCoaster().onAppear {
                        // waits 3.5 seconds before naviagiting to dashboard
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            print("firing now")
                            // will launch popup to name coaster
   
                        }
                    }
                }
                else if statusCodeResp == 200 {
                    CoasterHasDifferentHost(hostName: tempCoasterDetails.hostName, coasterName: tempCoasterDetails.coasterName).onAppear {
                        // waits 3.5 seconds before naviagiting to dashboard
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            print("firing now")
                            // will nav back to dashboard
   
                        }
                    }
                }
                // if theres an issue connecting
                else {
                    ZStack {
                        Color.amber.ignoresSafeArea()
                        VStack{
                            Spacer()
                            
                            // if its not in our db
                            if (statusCodeResp == 404 ) {
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
                            }).buttonStyle(NeumorphicButtonStyle(bgColor: .amber)).padding(.vertical, 100)
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
}

struct HostAddCoaster_Previews: PreviewProvider {
    static var previews: some View {
//        HostAddCoaster()
        Text("hey there")
    }
}

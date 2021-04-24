//
//  AlreadyJoinedAddNew.swift
//  Fonz Music App Clip
//
//  Created by didi on 4/22/21.
//

import SwiftUI

struct AlreadyJoinedAddNew: View {
//    // gets object to determine if the page should be updated
//    @Binding var determineGuestViewUpdate: UpdatePageViewVariables
//    // hostCoaster details passed in and will update view when changed
//    @ObservedObject var hostCoaster:HostCoasterInfo
//
//    // bool auto set to false, set to true if coaster has a host
//    @State var coasterHasHost = false
//
//    // temp Coaster Object so that page does not update BEFORE showing success page
//    @State var tempCoasterDetails = HostCoasterInfo()
//
//    @Binding var guestPageNumber:Int
//
//    @State var statusCodeResp = 0
//
//    // bool auto set to false, set to true if nfc is launched
//    @State var launchedNfc = false
//
    let hostName:String
    
    let imageHeight = UIScreen.screenHeight * 0.09
    var body: some View {
        // standard
//        if !didSessionChange(existingSessionId: hostCoaster.sessionId, newSessionId: tempCoasterDetails.sessionId) {
            ZStack {
                Color(red: 168 / 255, green: 127 / 255, blue: 169 / 255).ignoresSafeArea()
                VStack{
                    Spacer()
                    Image("rockOnWhite").resizable()
                        .frame(width: imageHeight, height: imageHeight * 1.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("you're already connected to \(hostName)'s party").fonzParagraphOne().padding()
                    Spacer()
//                    ShowNfcTryAgainButton(tempCoaster: $tempCoasterDetails, coasterHasHost: $coasterHasHost).padding(.horizontal, 30).padding(.vertical, 150)
                }
            }
//        }
//        // if the new host id is DIFFERENT than the new host id & the new host id is not blank
//        else {
//            JoinedParty(hostName: tempCoasterDetails.hostName, coasterName: tempCoasterDetails.coasterName).onAppear {
//                // waits 3.5 seconds before naviagiting to searchbar
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
//                    print("firing now")
//                    // changes hostCoaster details to return to parent
//                    self.hostCoaster.coasterName = tempCoasterDetails.coasterName
//                    self.hostCoaster.hostName = tempCoasterDetails.hostName
//                    self.hostCoaster.sessionId = tempCoasterDetails.sessionId
//                    self.hostCoaster.uid = tempCoasterDetails.uid
//                    // tells Pageview to update and WHAT page
//                    self.guestPageNumber = 1
////                                self.hasHostVar = true
//                }
//            }
//        }
    }
    
//    func didSessionChange(existingSessionId: String, newSessionId: String) -> Bool {
//        var sessionChanged = false
//        if newSessionId != "" && newSessionId != existingSessionId {
//            sessionChanged = true
//        }
//        return sessionChanged
//    }
}

struct AlreadyJoinedAddNew_Previews: PreviewProvider {
    static var previews: some View {
//        AlreadyJoinedAddNew(hostName: "frank")
        Text("heyp")
    }
}

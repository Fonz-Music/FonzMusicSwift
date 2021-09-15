//
//  CoasterDashboardPage.swift
//  FonzMusicSwift
//
//  Created by didi on 6/24/21.
//

import SwiftUI
import FirebaseAnalytics

struct CoasterDashboardPage: View {

// ---------------------------------- inherited from parent -----------------------------------------inherited from parent
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    // list of coasters connected to the Host
    @ObservedObject var coastersConnectedToHost: CoastersFromApi
    
// ---------------------------------- created inside view -------------------------------------------
    
    // bool auto set to false, set to true if nfc is launched
    @State var launchedNfc = false
    // temp Coaster Object so that page does not update BEFORE showing success page
    @State var tempCoasterDetails = HostCoasterInfo()
    // local var that is returned by nfc prompt when getting host from API
    @State var statusCodeResp = 0
    // if the coaster needs to be encoded
    @State var encodeTheCoaster = false
    // for the results of the search bar
    let layout = [
            GridItem(.flexible())
        ]
    @State private var selection: Set<HostCoasterResult> = []
    
    
  
    @Environment(\.colorScheme) var colorScheme
    
    @State var showRenameModal = false
    @State var showPauseModal = false
    @State var showTroubleShootModal = false
    @State var showDisconnectModal = false
    
    @State var addNewCoasterPressed = false
    
    @State var troubleShootCoasterPressed = false
    
    @State var showSuccessOrError = false
    
    
    var body: some View {
         
        VStack {
            
            // regular coaster dashboard
            if !launchedNfc {
                Spacer()
                    .frame(height: UIScreen.screenHeight * 0.15)
                ZStack {
                    RoundedRectangle(cornerRadius: .cornerRadiusBlocks)
                        .fill(colorScheme == .light ? Color.white: Color.darkBackground)
                        .fonzShadow()
                    
                        VStack{
                            // coasters
                            ScrollView(showsIndicators: true) {
                                LazyVGrid(columns: layout, spacing: 12) {

                                    ForEach(coastersConnectedToHost.products.coasters, id: \.self) { item in
                                        
                                        OwnedCoasterDropItem(item: item, isExpanded: self.selection.contains(item),  coastersConnectedToHost: coastersConnectedToHost, showRenameModal: $showRenameModal, showPauseModal: $showPauseModal, showTroubleShootModal: $showTroubleShootModal, showDisconnectModal:  $showDisconnectModal, troubleShootCoasterPressed: $troubleShootCoasterPressed, tempCoasterDetails: $tempCoasterDetails, userAttributes: userAttributes)
                                                .onTapGesture {
        //                                            if !self.selection.contains(item) {
                                                        self.selectDeselect(item)
        //                                            }
                                                    showRenameModal = false
                                                    showPauseModal = false
                                                    showTroubleShootModal = false
                                                    showDisconnectModal = false
                                                    print("here m8 ")
                                                    
                                                }
                                                .animation(.linear(duration: 0.3))
                                    }
                                }
                                .padding(.top, 5)
                                .padding(.bottom, 10)
                            }.frame(width: UIScreen.screenWidth * 0.9, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding(.top, 20)
                            .onAppear {
                                if coastersConnectedToHost.products.quantity == 0 {
                                    let actuallyHasCoasters = coastersConnectedToHost.determineIfHasCoasters()
                                    if (!actuallyHasCoasters) {
                                        userAttributes.setHasConnectedCoasters(bool: false)
                                    }
                                }
                            }
                            Spacer()
                            // add new button
                            AddNewCoasterButton(addNewCoasterPressed: $addNewCoasterPressed)
                            if addNewCoasterPressed {
                                LaunchConnectCoasterNfc(tempCoaster: $tempCoasterDetails, launchedNfc: $launchedNfc, statusCode: $statusCodeResp, pressedButtonToLaunchNfc: $addNewCoasterPressed).frame(maxWidth: 0, maxHeight: 0, alignment: .center)
                            }
                            if troubleShootCoasterPressed {
                                LaunchTroubleShootCoasterUrl(tempCoasterUid: $tempCoasterDetails.uid, statusCode: $statusCodeResp, launchedNfc: $launchedNfc, pressedButtonToLaunchNfc: $troubleShootCoasterPressed).frame(maxWidth: 0, maxHeight: 0, alignment: .center)
                            }
                        }
                    }
            }
            // displays resp from adding new coaster
            else {
                Spacer()
                    .frame(height: 20)
                // if host joins their first coaster propeerly, prompt name
                if statusCodeResp == 204 {

                    if (!tempCoasterDetails.encoded) {
                    // if coaster NOT encoded {
                    OneMoreStep()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                            troubleShootCoasterPressed = true
                                FirebaseAnalytics.Analytics.logEvent("userConnectCoaster", parameters: [
                                    "user":"host",
                                    "sessionId":tempCoasterDetails.sessionId,
                                    "userId":userAttributes.getUserId(),
                                    "group":tempCoasterDetails.group,
                                    "tagUid":tempCoasterDetails.uid,
                                    "device":"iOS"
                                ])
                            }
                        }
                    if troubleShootCoasterPressed {
                        EncodeCoasterWithUrl(tempCoasterUid: tempCoasterDetails.uid, statusCode: $statusCodeResp, pressedButtonToLaunchNfc: $troubleShootCoasterPressed)
                            .frame(width: 0, height: 0)
                    }
                    
                    if statusCodeResp == 600 {
                        VStack {

                            // name coaster
                            NameNewCoaster(launchedNfc: $launchedNfc, coasterUid: tempCoasterDetails.uid, coastersConnectedToHost: coastersConnectedToHost)
                            Spacer()
                        }
                    }
                     }
                    else {
                    
                    VStack {

                        // name coaster
                        NameNewCoaster(launchedNfc: $launchedNfc, coasterUid: tempCoasterDetails.uid, coastersConnectedToHost: coastersConnectedToHost)
                        Spacer()
                    }
                    }
                    
                }
//                // coaster belongs to you (should not appear)
//                else if statusCodeResp == 403 {
//                    ThisIsYourCoaster(coasterName: tempCoasterDetails.coasterName)
//                    // add options
//                }
                
                // coaster should be named after being encoded
                else if statusCodeResp == 602 {
                    VStack {

                        // name coaster
                        NameNewCoaster(launchedNfc: $launchedNfc, coasterUid: tempCoasterDetails.uid, coastersConnectedToHost: coastersConnectedToHost)
                        
                        Spacer()
                    }
                }
                
                // coaster has been trouble shooted
                else if statusCodeResp == 600 {
                    
                    VStack {

                        // name coaster
                        SuccessFulTroubleShoot()
                        Spacer()
                    }
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                            withAnimation {
                                if !addNewCoasterPressed {
                                    launchedNfc = false
                                }

                            }
                        }
                    }
                }
                // coaster has been trouble shooted FAIL
                else if statusCodeResp == 601 {
                    // this is someone else's coaster
                    VStack {

                        // show user failed coaster
                        FailCircleResponse(errorMessage: "troubleshoot failed")
                        Spacer()
                    }
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation {
//                                if !addNewCoasterPressed {
//                                    launchedNfc = false
//                                }
                                statusCodeResp = 204

                            }
                        }
                    }
                }
                
                else {
                    ZStack {
                        // coaster belongs to someone else
                        if statusCodeResp == 403 {
                            // this is someone else's coaster

                            SomeoneElsesCoaster(coasterName: tempCoasterDetails.coasterName, hostName: tempCoasterDetails.hostName)
                            Spacer()
                        }
                        // coaster belongs to you (should not appear)
                        else if statusCodeResp == 200 {

                            ThisIsYourCoaster(coasterName: tempCoasterDetails.coasterName)
                            Spacer()
                            // add options
                        }
                        
                        else {
                            FailCircleResponse(errorMessage: "adding the new coaster failed")
                                .animation(.easeInOut(duration: 2))
                                .onAppear{
                                    FirebaseAnalytics.Analytics.logEvent("userConnectFirstCoasterFail", parameters: ["user":"user",
                                                                                                                     "userId":userAttributes.getUserId(),
                                                                                                                     "tagUid":tempCoasterDetails.uid ?? "",
                                                                                                                     "device":"iOS"])
                                }
                        }
                    }
//                    .padding(.top, 100)
                    .isHidden(!showSuccessOrError)
                    .onAppear {
                        // shows success or error view
                        withAnimation {
                            showSuccessOrError = true
                            addNewCoasterPressed = false
                        }
                        // after 7 seconds, resets home page to normal if connection fails
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
                            withAnimation {
                                if !addNewCoasterPressed {
                                    launchedNfc = false
                                }

                            }
                        }
                    }
                    Spacer()
                }

            }
            
        }
        .ignoresSafeArea()

        
        
    }
    
    
    private func selectDeselect(_ coaster: HostCoasterResult) {
            if selection.contains(coaster) {
                selection.remove(coaster)
            } else {
                selection.insert(coaster)
            }
        }
}




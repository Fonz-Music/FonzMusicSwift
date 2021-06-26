//
//  CoasterDashboardPage.swift
//  FonzMusicSwift
//
//  Created by didi on 6/24/21.
//

import SwiftUI

struct CoasterDashboardPage: View {

// ---------------------------------- inherited from parent -----------------------------------------

    
// ---------------------------------- created inside view -------------------------------------------
    // object that stores the songs from the api
    @ObservedObject var hostCoasterList: CoastersFromApi
    // bool auto set to false, set to true if nfc is launched
    @State var launchedNfc = false
    // temp Coaster Object so that page does not update BEFORE showing success page
    @State var tempCoasterDetails = HostCoasterInfo()
    // local var that is returned by nfc prompt when getting host from API
    @State var statusCodeResp = 0
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
    
    @State var showSuccessOrError = false
    
    var body: some View {
         
        VStack {
            Spacer()
                .frame(height: UIScreen.screenHeight * 0.2)
            // regular coaster dashboard
            if !launchedNfc {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(colorScheme == .light ? Color.white: Color.darkBackground)
                        .shadow(radius: 3)
                    
                        VStack{
                            // coasters
                            ScrollView(showsIndicators: true) {
                                LazyVGrid(columns: layout, spacing: 12) {

                                    ForEach(hostCoasterList.products.coasters, id: \.self) { item in
                                        
                                        OwnedCoasterDropItem(item: item, isExpanded: self.selection.contains(item),  coasterFromSearch: hostCoasterList, showRenameModal: $showRenameModal, showPauseModal: $showPauseModal, showTroubleShootModal: $showTroubleShootModal, showDisconnectModal:  $showDisconnectModal)
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
                            }.frame(width: UIScreen.screenWidth * 0.9, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding(.top, 30)
                            Spacer()
                            // add new button
                            AddNewCoasterButton(addNewCoasterPressed: $addNewCoasterPressed)
                            if addNewCoasterPressed {
                                LaunchConnectCoasterNfc(tempCoaster: $tempCoasterDetails, launchedNfc: $launchedNfc, statusCode: $statusCodeResp, pressedButtonToLaunchNfc: $addNewCoasterPressed).frame(maxWidth: 0, maxHeight: 0, alignment: .center)
                            }
                        }
                    }
            }
            // displays resp from adding new coaster
            else {
                Spacer()
                    .frame(height: 75)
                // if host joins their first coaster propeerly, prompt name
                if statusCodeResp == 204 {
                    VStack {
                        
                        // name coaster
                        NameNewCoaster(launchedNfc: $launchedNfc, coasterUid: tempCoasterDetails.uid)
                        Spacer()
                    }
                }
                // coaster belongs to you (should not appear)
                else if statusCodeResp == 403 {
                    // this is someone else's coaster
                    Text("this is your coaster \(tempCoasterDetails.coasterName)")
                }
                
                else {
                    ZStack {
                        // coaster belongs to someone else
                        if statusCodeResp == 200 {
                            // this is someone else's coaster
                            Text("this coaster belongs to \(tempCoasterDetails.hostName) & is named \(tempCoasterDetails.coasterName)")
                        }
                        
                        else {
                            FailPartyJoin(pressedButtonToLaunchNfc: $addNewCoasterPressed, errorMessage: "you did not join the party. press to try again", errorImage: "disableIcon")
                                .animation(.easeInOut(duration: 2))
                            if addNewCoasterPressed {
                                LaunchConnectCoasterNfc(tempCoaster: $tempCoasterDetails, launchedNfc: $launchedNfc, statusCode: $statusCodeResp, pressedButtonToLaunchNfc: $addNewCoasterPressed).frame(maxWidth: 0, maxHeight: 0, alignment: .center)
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
                        DispatchQueue.main.asyncAfter(deadline: .now() + 7.5) {
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




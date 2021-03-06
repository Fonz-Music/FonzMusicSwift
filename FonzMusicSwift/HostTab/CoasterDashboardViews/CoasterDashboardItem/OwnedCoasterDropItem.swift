//
//  OwnedCoasterDropItem.swift
//  FonzMusicSwift
//
//  Created by didi on 6/24/21.
//

import SwiftUI

struct OwnedCoasterDropItem: View {
    
    

    // the song passed in
    let item: HostCoasterResult
    var isExpanded: Bool

    @ObservedObject var coastersConnectedToHost: CoastersFromApi

    @Binding var showRenameModal : Bool
    @Binding var showPauseModal : Bool
    @Binding var showTroubleShootModal : Bool
    @Binding var showDisconnectModal : Bool
    @Binding var troubleShootCoasterPressed : Bool
    // temp Coaster Object to pass to trouble shoot to write correct uid
    @Binding var tempCoasterDetails : HostCoasterInfo
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    
    
    @Environment(\.colorScheme) var colorScheme
  
    var body: some View {
        ZStack {
            VStack {
                // top line
                CoasterNameInDashboard(item: item, isExpanded: isExpanded)
                if isExpanded {
                    ZStack {
                    if showRenameModal {
                        RenameCoasterField(showRenameModal: $showRenameModal,  coasterUid: item.coasterId, coastersConnectedToHost: coastersConnectedToHost)
                    }
                    else if showPauseModal {
                        PauseCoasterField(showPauseModal: $showPauseModal, active: item.active, coasterUid: item.coasterId, coastersConnectedToHost: coastersConnectedToHost)
                    }
                    else if showTroubleShootModal {
                        TroubleShootCoasterField(showTroubleShootModal: $showTroubleShootModal, coasterUid: item.coasterId, troubleShootCoasterPressed: $troubleShootCoasterPressed, tempCoasterDetails: $tempCoasterDetails)
                    }
                    else if showDisconnectModal {
                        DisconnectCoasterField(showDisconnectModal: $showDisconnectModal, coasterUid: item.coasterId, coastersConnectedToHost: coastersConnectedToHost, userAttributes: userAttributes)
                    }
                    // all options
                    else {
                        VStack {
                            // rename button
                            RenameCoasterButton(showRenameModal: $showRenameModal)
                            // pause button
                            PauseCoasterButton(item: item, showPauseModal: $showPauseModal)
                            // troubleshoot button
                            TroubleShootCoasterButton(showTroubleShootModal: $showTroubleShootModal)
                            // disconnect button
                            DisconnectCoasterButton(showDisconnectModal: $showDisconnectModal)
                        }
                    }
                    
                    }
                    .onTapGesture {
                        print("tapped")
//                        self.pressedToCompressButton = true
                    }
                }
            }
        }
        .frame(minHeight: 50, maxHeight: 350)
        .background(
            RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                .fill(colorScheme == .light ? Color.white: Color.darkButton)
                .fonzShadow()
        )
        .padding(.horizontal, 10)
        .animation(.easeIn)
        
    }
    
    
   
}

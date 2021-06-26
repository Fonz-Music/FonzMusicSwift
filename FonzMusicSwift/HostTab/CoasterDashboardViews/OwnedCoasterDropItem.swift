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

    @ObservedObject var coasterFromSearch: CoastersFromApi
    
//    @State var showRenameModal = false
//    @State var showPauseModal = false
//    @State var showTroubleShootModal = false
//    @State var showDisconnectModal = false
    
    @Binding var showRenameModal : Bool
    @Binding var showPauseModal : Bool
    @Binding var showTroubleShootModal : Bool
    @Binding var showDisconnectModal : Bool
    
    @Environment(\.colorScheme) var colorScheme
  
    var body: some View {
        ZStack {
            VStack {
                // top line
                CoasterNameInDashboard(item: item, isExpanded: isExpanded)
                if isExpanded {
                    ZStack {
                    if showRenameModal {
                        RenameCoasterField(showRenameModal: $showRenameModal, coasterUid: item.coasterId)
                    }
                    else if showPauseModal {
                        PauseCoasterField(showPauseModal: $showPauseModal, paused: item.active, coasterUid: item.coasterId)
                    }
                    else if showTroubleShootModal {
                        TroubleShootCoasterField(showTroubleShootModal: $showTroubleShootModal, coasterUid: item.coasterId)
                    }
                    else if showDisconnectModal {
                        DisconnectCoasterField(showDisconnectModal: $showDisconnectModal, coasterUid: item.coasterId)
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

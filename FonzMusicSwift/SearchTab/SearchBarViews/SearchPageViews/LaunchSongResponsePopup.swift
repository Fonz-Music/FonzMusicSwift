//
//  LaunchSongResponsePopup.swift
//  FonzMusicSwift
//
//  Created by didi on 7/1/21.
//

import SwiftUI

struct LaunchSongResponsePopup: View {
    
    var statusCodeQueueSong : Int
    @Binding var showQueueResponse : Bool
    var songSelected : String
    var currentHost : String
    
    var body: some View {
        VStack {
            // success
            if statusCodeQueueSong == 200 {
                QueueSongSuccess(songAddedName: songSelected, currentHost: currentHost)
                    
                    .padding(.top, 10)
            }
            // no active song
            else if (statusCodeQueueSong == 404 || statusCodeQueueSong == 403 || statusCodeQueueSong == 401) {
                QueuedButDelayedResponse()
                    .padding(.top, 10)
            }
            // nfc error
            else if statusCodeQueueSong == 500 {
                QueueSongError()
                    .padding(.top, 10)
            }
            Spacer()
        }
        .animation(.easeInOut)
        .isHidden(!showQueueResponse)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                withAnimation {
                    showQueueResponse = false
                }
            }
        }
    }
}

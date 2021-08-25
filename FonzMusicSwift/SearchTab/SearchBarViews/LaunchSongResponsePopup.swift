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
    
//    // hostCoaster details passed in and will update view when changed
//    @ObservedObject var hostCoaster:HostCoasterInfo
//    // track object inherited from song search
//    @StateObject var currentTune:GlobalTrack
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Button(action: {
            }, label: {
            VStack {
                // success
                if statusCodeQueueSong == 200 {
                    QueueSongSuccess(songAddedName: songSelected, currentHost: currentHost)
                        
//                        .padding(.top, 10)
                }
                // no active song
                else if (statusCodeQueueSong == 404 || statusCodeQueueSong == 403 || statusCodeQueueSong == 401) {
                    QueuedButDelayedResponse()
//                        .padding(.top, 10)
                }
                // if the userId do not match
                else if (statusCodeQueueSong == 1) {
                    QueueFailYourHostDoesNotOwnThatCoaster()
//                        .padding(.top, 10)
                }
                // nfc error
                else {
                    QueueSongError()
//                        .padding(.top, 10)
                }
//                Spacer()
            }
            })
            .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .successGreen, selectedOption: true))
            .padding(.top, 10)
            .frame(width: UIScreen.screenWidth * 0.9, height: 60)
            .disabled(true)
            .animation(.easeInOut)
            .isHidden(!showQueueResponse)
            .onAppear {
//                if (currentTune.songId != "") {
//                    withAnimation{
//                        statusCodeQueueSong = GuestApi().queueSong(sessionId: hostCoaster.sessionId, trackId: currentTune.songId)
//                    }
//                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                    withAnimation {
                        showQueueResponse = false
                    }
                }
            }
            Spacer()
        }
        
    }
}

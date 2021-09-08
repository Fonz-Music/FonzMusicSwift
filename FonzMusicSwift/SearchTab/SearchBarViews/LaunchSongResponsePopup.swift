//
//  LaunchSongResponsePopup.swift
//  FonzMusicSwift
//
//  Created by didi on 7/1/21.
//

import SwiftUI
import FirebaseAnalytics

struct LaunchSongResponsePopup: View {
    
    var statusCodeQueueSong : Int
    @Binding var showQueueResponse : Bool
    var songSelected : String
//    var currentHost : String
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    
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
                    QueueSongSuccess(songAddedName: songSelected, currentHost: hostCoaster.hostName)
                        .onAppear {
                            FirebaseAnalytics.Analytics.logEvent("songQueueSuccess", parameters: [
                                "user":"guest",
                                "sessionId":hostCoaster.sessionId,
                                "userId":userAttributes.getUserId(),
                                "group":hostCoaster.group,
                                "tagUid":hostCoaster.uid.uppercased() ,
                                "songQueued":songSelected,
                                "device":"iOS"
                            ])
                        }
                    
//                        .padding(.top, 10)
                }
                // no active song
                else if (statusCodeQueueSong == 402 || statusCodeQueueSong == 401) {
                    QueuedButDelayedResponse()
                        .onAppear {
                            FirebaseAnalytics.Analytics.logEvent("songQueueFail", parameters: [
                                "user":"guest",
                                "sessionId":hostCoaster.sessionId,
                                "userId":userAttributes.getUserId(),
                                "group":hostCoaster.group,
                                "tagUid":hostCoaster.uid.uppercased(),
                                "failureReason":"no active song",
                                "device":"iOS"
                            ])
                        }
//                        .padding(.top, 10)
                }
                else if (statusCodeQueueSong == 403) {
                    QueuedButDelayedResponse()
                        .onAppear {
                            FirebaseAnalytics.Analytics.logEvent("songQueueFail", parameters: [
                                "user":"guest",
                                "sessionId":hostCoaster.sessionId,
                                "userId":userAttributes.getUserId(),
                                "group":hostCoaster.group,
                                "tagUid":hostCoaster.uid.uppercased(),
                                "failureReason":"restricted device",
                                "device":"iOS"
                            ])
                        }
                }
                // if the userId do not match
                else if (statusCodeQueueSong == 1) {
                    QueueFailYourHostDoesNotOwnThatCoaster()
                        
//                        .padding(.top, 10)
                }
                // nfc error
                else {
                    QueueSongError()
//                        .onAppear {
//                            FirebaseAnalytics.Analytics.logEvent("songQueueFail", parameters: [
//                                "user":"guest",
//                                "sessionId":hostCoaster.sessionId,
//                                "userId":userAttributes.getUserId(),
//                                "group":hostCoaster.group,
//                                "tagUid":hostCoaster.uid
//                            ])
//                        }
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

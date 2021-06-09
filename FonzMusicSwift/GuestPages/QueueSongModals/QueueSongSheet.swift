//
//  QueueSongSheet.swift
//  Fonz Music App Clip
//
//  Created by didi on 3/16/21.
//

import SwiftUI
import Combine
import CoreNFC
import UIKit

struct QueueSongSheet: View {
// ---------------------------------- inherited from parent -----------------------------------------
    // track object inherited from song search
    var currentTune:GlobalTrack
    // coaster info, has sessionId + uid
    var hostCoaster:HostCoasterInfo
    // bool that determines if this song sheet should be launched.
    // is set to false after nfc prompt returns
    @Binding var queuePopupPresent: Bool
        
// ---------------------------------- created inside view -------------------------------------------
    // init var that keeps status code
    @State var statusCodeQueueSong = 0
    // bool auto set to false, set to true if nfc is launched
    @State var launchedNfc = false
    
    let imageHeight = UIScreen.screenHeight * 0.15
    
    var body: some View {
        // after the prompt has alrady returned
        if (launchedNfc) {
            // if song queued successfully, show success page
            if statusCodeQueueSong == 200 {
                SuccessQueueSong(hostName: self.hostCoaster.hostName).onAppear {
                    // wait 2.5 secs
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        // tells popup to dismiss
                        self.queuePopupPresent = false
                    }
//                    ShareImageOnInstagram(imageUrl: self.currentTune.albumArt, songTitle: self.currentTune.songName, artistName: self.currentTune.artistName)
                }
                
            }
            // if theres an error, show error page
            else if statusCodeQueueSong == 404 || statusCodeQueueSong == 403 || statusCodeQueueSong == 401 || statusCodeQueueSong == 500 {
                ErrorQueuingSong(hostName: self.hostCoaster.hostName).onAppear {
                    // wait 5.5 sec
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
                        print("should be setting to false")
                        // tells popup to dismiss
                        self.queuePopupPresent = false
                    }
                }
            }
            else if statusCodeQueueSong == 1 {
                ErrorNotSameCoaster().onAppear {
                    // wait 5.5 sec
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
                        print("should be setting to false")
                        // tells popup to dismiss
                        self.queuePopupPresent = false
                    }
                }
            }
            else {
                ErrorOnTap().onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                        print("should be setting to false")
                        // tells popup to dismiss
                        self.queuePopupPresent = false
                    }
                }
            }
        }
        // if they havent queued a song yet
        else {
            ZStack {
                Color(red: 168 / 255, green: 127 / 255, blue: 169 / 255).ignoresSafeArea()
                VStack{
                    Spacer()
                    Text("your selection").fonzHeading().padding(.top, 40)
                    // album art
                    AsyncImage(url: URL(string: self.currentTune.albumArt)!,
                               placeholder: { Text("...").fonzParagraphTwo() },
                                   image: { Image(uiImage: $0).resizable() })
                        .frame( width: UIScreen.main.bounds.width * 0.4,height: UIScreen.main.bounds.width * 0.4).cornerRadius(15).padding() // 2:3 aspect ratio
                    // song title
                    Text("\(self.currentTune.songName)").fonzHeading()
                    // artist
                    Text("\(self.currentTune.artistName)").fonzParagraphOne()
                    Spacer()
                    // launches nfc prompt & queues song
                    LaunchQueueSongNfcSessionSheet(hostCoaster: hostCoaster, songInfo: currentTune, statusCode: $statusCodeQueueSong, launchedNfc: $launchedNfc)
//                    LaunchQueueSongWriteUrl(hostCoaster: hostCoaster, songInfo: currentTune, statusCode: $statusCodeQueueSong, launchedNfc: $launchedNfc)
                    Spacer()
                }
            }.onAppear {
                print("\(self.currentTune.albumArt)")
            }
        }
    }
}

struct QueueSongSheet_Previews: PreviewProvider {
    static var previews: some View {
//        QueueSong().environmentObject(GlobalVars())
        Text("piss off")
    }
}

//// --------------------------------- following code just allows to show album art from url ------------------

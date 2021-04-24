//
//  LaunchQueueSongNfc.swift
//  Fonz Music App Clip
//
//  Created by didi on 4/20/21.
//

import Foundation
import SwiftUI
import CoreNFC
import UIKit

struct LaunchQueueSongWriteUrl: UIViewRepresentable {

    
    func makeCoordinator() -> LaunchQueueSongWriteUrl.Coordinator {
        return Coordinator(hostCoaster, songInfo, statusCode: $statusCode, launchedNfc: $launchedNfc)
    }
    
    // coaster info
    @ObservedObject var hostCoaster:HostCoasterInfo
    // takes in selected song
    @ObservedObject var songInfo:GlobalTrack
    // takes in status code to return to parent
    @Binding var statusCode:Int
    // changes to true when nfc launches
    @Binding var launchedNfc:Bool
    
    
    func makeUIView(context: UIViewRepresentableContext<LaunchQueueSongWriteUrl>) -> UIButton {
        let button = UIButton()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            context.coordinator.launchNfcScan()
        }
        return button
    }
    
    
    
    func updateUIView(_ uiView: UIButton, context: Context) {
        // do nothing
    }
    
    class Coordinator: NSObject, NFCNDEFReaderSessionDelegate {
        @ObservedObject var hostCoaster:HostCoasterInfo
        @ObservedObject var songInfo:GlobalTrack
        @Binding var statusCode:Int
        @Binding var launchedNfc:Bool
//        @Binding var songLoaded:Bool
        
        var writeSession: NFCNDEFReaderSession?
        
        
        init(_ hostCoaster: HostCoasterInfo, _ songInfo: GlobalTrack, statusCode: Binding<Int>, launchedNfc: Binding<Bool>) {
            
            self.hostCoaster = hostCoaster
            self.songInfo = songInfo
            _statusCode = statusCode
            _launchedNfc = launchedNfc
        }
        
        func launchNfcScan() {
            self.writeSession = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: true)
            print("starting scan sheet")
            // this createss nfc alert
            self.writeSession?.alertMessage = "scan the Fonz Coaster"
            print("beginning scan sheet")
            // this begins the alert
            self.writeSession?.begin()
        }
       
        // swift protcol if error
        func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
//            DispatchQueue.main.async {
//                session.invalidate()
//                print(error.localizedDescription)
//            }
            session.invalidate(errorMessage: "connection failed")
            self.launchedNfc = true
        }
        // swift protocol check if active
        func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
                print("became active")
        }
        // keep blank, reads the payload
        func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
            // nothing
        }
        // this runs once scan is launched, writes to coaster
        func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        
            print("got to reader session")
            // inits first tag as active coaster
            let tag = tags.first!
            // connects to that tag
            session.connect(to: tag) { (error: Error?) in
                    // ensures that it is an NDEF tag
                    tag.queryNDEFStatus() { (status: NFCNDEFStatus, capacity: Int, error: Error?) in

                        print("creating url")
                        //  creates url w the coaster uid on it
                        let urlWithUid = "https://fonzmusic.com/" + self.hostCoaster.uid.uppercased()
                        // inits the URL
                        let uriPayloadFromURL = NFCNDEFPayload.wellKnownTypeURIPayload(
                            url: URL(string: urlWithUid)!
                        )!
                        let myMessage = NFCNDEFMessage.init(records: [uriPayloadFromURL])
                        // function writes the url onto the tag
                        tag.writeNDEF(myMessage) { (error) in
                            if let error = error {
                                print("\(error)")
                                session.alertMessage = "uh oh!"
                            }
                            else {
                                session.alertMessage = "properly connected!"
                            }
                            print("wrote nfc")
                            // ends session
                            session.invalidate()
                            // creates apiConnection
                            let apiConnection = GuestApi()
                            // calls function to queue that song from the API
                            let statusCodeFromApi = apiConnection.queueSong(sessionId: self.hostCoaster.sessionId, trackId: self.songInfo.songId)
                            print("status code " + String(statusCodeFromApi))
                            
                            DispatchQueue.main.async {
                                self.launchedNfc = true
                                // send the status code
                                self.statusCode = statusCodeFromApi
                            }
                        }
                    }
                }
            }
    }
}

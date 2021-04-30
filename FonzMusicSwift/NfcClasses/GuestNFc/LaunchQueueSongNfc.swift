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

struct LaunchQueueSongNfcSessionSheet: UIViewRepresentable {

    
    func makeCoordinator() -> LaunchQueueSongNfcSessionSheet.Coordinator {
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
    
    
    func makeUIView(context: UIViewRepresentableContext<LaunchQueueSongNfcSessionSheet>) -> UIButton {
        let button = UIButton()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            context.coordinator.launchNfcScan()
        }
        return button
    }
    
    
    
    func updateUIView(_ uiView: UIButton, context: Context) {
        // do nothing
    }
    
    class Coordinator: NSObject, NFCTagReaderSessionDelegate {
        @ObservedObject var hostCoaster:HostCoasterInfo
        @ObservedObject var songInfo:GlobalTrack
        @Binding var statusCode:Int
        @Binding var launchedNfc:Bool
//        @Binding var songLoaded:Bool
        
        var session: NFCTagReaderSession?
        
        init(_ hostCoaster: HostCoasterInfo, _ songInfo: GlobalTrack, statusCode: Binding<Int>, launchedNfc: Binding<Bool>) {
            
            self.hostCoaster = hostCoaster
            self.songInfo = songInfo
            _statusCode = statusCode
            _launchedNfc = launchedNfc
        }
       
        
        // function that fires when button is pressed
        @objc func beginNfcScan(_ sender: Any) {
            self.session = NFCTagReaderSession(pollingOption: .iso14443, delegate: self)
            print("starting scan sheet")
            // this createss nfc alert
            self.session?.alertMessage = "scan the Fonz Coaster"
            print("beginning scan sheet")
            // this begins the alert
            self.session?.begin()
        }
        func launchNfcScan() {
            self.session = NFCTagReaderSession(pollingOption: .iso14443, delegate: self)
            print("starting scan sheet")
            // this createss nfc alert
            self.session?.alertMessage = "scan the Fonz Coaster"
            print("beginning scan sheet")
            // this begins the alert
            self.session?.begin()
        }
        
        func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
            print("session begun sheet")
        }
        
        func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
            
            print(Error.self)
            print("yikes")
            session.invalidate()
            self.launchedNfc = true
        }
        
        // if the nfc read connects
        func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
            // checks for only 1 tag
            if tags.count > 1 {
                print("morethan one ")
                session.alertMessage = "more than one tag detected, please try again"
                session.invalidate()
                self.launchedNfc = true
            }
            session.connect(to: tags.first!) { (error: Error?) in
                if nil != error{
                    print("connection failed")
                    session.invalidate(errorMessage: "connection failed")
                    self.launchedNfc = true
                }
                if case let NFCTag.miFare(sTag) = tags.first! {
                    // sets uid
                    let UID = sTag.identifier.map{
                        String(format: "%.2hhx", $0) }.joined()
                    print("UID:" + UID)

                    session.alertMessage = "properly connected!"
                    
                    // if the uid is the same as the host uid
                    if (UID == self.hostCoaster.uid) {
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
//                            self.statusCode = 404
                        }
                    }
                    // if the uid is different
                    else {
                        session.invalidate()
                        print("status code " + String(self.statusCode))
                        DispatchQueue.main.async {
                            // send the status code
                            self.launchedNfc = true
                            self.statusCode = 1
                        }
                    }
                }
            }
        }
    }
 
    

}

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
        return Coordinator(tempCoaster, songInfo, statusCode: $statusCode, launchedNfc: $launchedNfc, pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc)
    }
    
    // temp coaster to update page
    @ObservedObject var tempCoaster:HostCoasterInfo
    // takes in selected song
    @ObservedObject var songInfo:GlobalTrack
    // takes in status code to return to parent
    @Binding var statusCode:Int
    // changes to true when nfc launches
    @Binding var launchedNfc:Bool
    // boolean on whether the button has been pressed
    @Binding var pressedButtonToLaunchNfc:Bool
    
    func makeUIView(context: UIViewRepresentableContext<LaunchQueueSongNfcSessionSheet>) -> UIButton {
        let button = UIButton()
        button.isHidden = true
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            context.coordinator.launchNfcScan()
//        }
        return button
    }
    
    
    
    func updateUIView(_ uiView: UIButton, context: Context) {
        // do nothing
    }
    
    class Coordinator: NSObject, NFCTagReaderSessionDelegate {
        // temp coaster to update page
        @ObservedObject var tempCoaster:HostCoasterInfo
        // object of the current song
        @ObservedObject var songInfo:GlobalTrack
        // boolean on whether the nfc has finished or not
        @Binding var launchedNfc:Bool
        // takes in status code to return to parent
        @Binding var statusCode:Int
        // boolean on whether the button has been pressed
        @Binding var pressedButtonToLaunchNfc:Bool
        
        var session: NFCTagReaderSession?
        
        init(
            _ tempCoaster: HostCoasterInfo,
            _ songInfo: GlobalTrack,
            statusCode: Binding<Int>,
            launchedNfc: Binding<Bool>,
            pressedButtonToLaunchNfc: Binding<Bool>
        ) {
            
            self.songInfo = songInfo
            _launchedNfc = launchedNfc
            self.tempCoaster = tempCoaster
            _statusCode = statusCode
            _pressedButtonToLaunchNfc = pressedButtonToLaunchNfc
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
            self.pressedButtonToLaunchNfc = false
        }
        
        // if the nfc read connects
        func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
            // checks for only 1 tag
            if tags.count > 1 {
                print("morethan one ")
                session.alertMessage = "more than one tag detected, please try again"
                session.invalidate()
                self.launchedNfc = true
                self.pressedButtonToLaunchNfc = false
            }
            session.connect(to: tags.first!) { [self] (error: Error?) in
                if nil != error{
                    print("connection failed")
                    session.invalidate(errorMessage: "connection failed")
                    self.launchedNfc = true
                    self.pressedButtonToLaunchNfc = false
                }
                if case let NFCTag.miFare(sTag) = tags.first! {
                    // sets uid
                    let UID = sTag.identifier.map{
                        String(format: "%.2hhx", $0) }.joined()
                    print("UID:" + UID)

                    session.alertMessage = "properly connected!"
                    var statusCodeFromApi = 0
                    // if the uid is the same as the host uid
                    if (UID == self.tempCoaster.uid) {
                        session.invalidate()
                        // creates apiConnection
                        let apiConnection = GuestApi()
                        print("song id id \(self.songInfo.songId)")
                        if (self.songInfo.songId != nil && self.songInfo.songId != "") {
                            statusCodeFromApi = apiConnection.queueSong(sessionId: self.tempCoaster.sessionId, trackId: self.songInfo.songId)
                        }
                        // calls function to queue that song from the API
                       
                        print("status code " + String(statusCodeFromApi))
                        
                        DispatchQueue.main.async {
                            self.launchedNfc = true
                            // send the status code
                            self.statusCode = statusCodeFromApi
//                            self.statusCode = 404
                            self.pressedButtonToLaunchNfc = false
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
                            self.pressedButtonToLaunchNfc = false
                        }
                    }
                }
            }
        }
    }
 
    

}

//
//  EncodeCoasterWithUrl.swift
//  FonzMusicSwift
//
//  Created by didi on 7/29/21.
//


import Foundation
import SwiftUI
import CoreNFC
import UIKit

struct EncodeCoasterWithUrl: UIViewRepresentable {

    
    func makeCoordinator() -> EncodeCoasterWithUrl.Coordinator {
        return Coordinator(tempCoasterUid: tempCoasterUid, statusCode: $statusCode, pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc)
    }
    
    // temp coaster to update page
    var tempCoasterUid:String
    // takes in status code to return to parent
    @Binding var statusCode:Int
    // boolean on whether the button has been pressed, used
    // to show animation on nfc launch
    @Binding var pressedButtonToLaunchNfc:Bool
    
    
    func makeUIView(context: UIViewRepresentableContext<EncodeCoasterWithUrl>) -> UIButton {
        let button = UIButton()
        button.isHidden = true
        
            context.coordinator.launchNfcScan()
        
        return button
    }
    
    
    
    func updateUIView(_ uiView: UIButton, context: Context) {
        // do nothing
    }
    
    class Coordinator: NSObject, NFCNDEFReaderSessionDelegate {
        // temp coaster to update page
        var tempCoasterUid:String
        @Binding var statusCode:Int
        // boolean on whether the button has been pressed
        @Binding var pressedButtonToLaunchNfc:Bool
        
        var writeSession: NFCNDEFReaderSession?
        
        
        init(tempCoasterUid: String, statusCode: Binding<Int>,
             pressedButtonToLaunchNfc: Binding<Bool>) {
            
            self.tempCoasterUid = tempCoasterUid
            _statusCode = statusCode
            _pressedButtonToLaunchNfc = pressedButtonToLaunchNfc
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
            self.statusCode = 601
//            self.launchedNfc = true
            self.pressedButtonToLaunchNfc = false
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
                        let urlWithUid = "https://fonzmusic.com/" + self.tempCoasterUid.uppercased()
                        // inits the URL
                        let uriPayloadFromURL = NFCNDEFPayload.wellKnownTypeURIPayload(
                            url: URL(string: urlWithUid)!
                        )!
                        let myMessage = NFCNDEFMessage.init(records: [uriPayloadFromURL])
                        // function writes the url onto the tag
                        tag.writeNDEF(myMessage) { (error) in
                            let statusCodeFromWrite : Int
                            if let error = error {
                                print("\(error)")
                                session.alertMessage = "uh oh!"
                                statusCodeFromWrite = 601
                            }
                            else {
                                session.alertMessage = "properly connected!"
                                statusCodeFromWrite = 602
                                // tells api that they're encoded
                                HostCoastersApi().markCoasterAsEncoded(coasterUid: self.tempCoasterUid.uppercased())
                            }
                            print("wrote nfc")
                            // ends session
                            session.invalidate()
                        
                            
                            DispatchQueue.main.async {
//                                self.launchedNfc = true
                                self.pressedButtonToLaunchNfc = false
                                // send the status code
                                self.statusCode = statusCodeFromWrite
                            }
                        }
                    }
                }
            }
    }
}

//
//  TryAgainNfcButton.swift
//  Fonz Music App Clip
//
//  Created by didi on 4/20/21.
//

import Foundation
import SwiftUI
import CoreNFC
import UIKit

struct ShowNfcTryAgainButton: UIViewRepresentable {
    func makeCoordinator() -> ShowNfcTryAgainButton.Coordinator {
        return Coordinator(launchedNfc: $launchedNfc, tempCoaster: $tempCoaster, statusCode: $statusCode, pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc)
//        return Coordinator(uid: $uid)
    }
    
    // temp coaster to update page
    @Binding var tempCoaster:HostCoasterInfo
    // boolean on whether the nfc has finished or not
    @Binding var launchedNfc:Bool
    // takes in status code to return to parent
    @Binding var statusCode:Int
    // boolean on whether the button has been pressed
    @Binding var pressedButtonToLaunchNfc:Bool


    func makeUIView(context: UIViewRepresentableContext<ShowNfcTryAgainButton>) -> UIButton {
        print("drawing uibutton ")
  
        
        let button = UIButton()
        button.isHidden = true
//        button.setTitle("press to connect again", for: .normal)
//        button.setTitleColor(UIColor.systemGray5, for: .normal)
//        button.titleLabel?.font = UIFont.init(name: "MuseoSans-500", size: 24)
//        button.backgroundColor = UIColor(red: 168 / 255, green: 127 / 255, blue: 169 / 255, alpha: 0)
//        button.layer.borderWidth = 2
//        button.layer.borderColor = UIColor.systemGray5.cgColor
//
//        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//        button.layer.shadowOpacity = 1
//        button.layer.shadowRadius = 0.0
//
//        button.addTarget(context.coordinator, action: #selector(context.coordinator.beginNfcScan(_:)), for: .valueChanged)
//
        if (pressedButtonToLaunchNfc) {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                print("launching nfc scan ")
                context.coordinator.launchNfcScanWithoutButton()
//            }
        }
        return button

    }
    
    

    

    func updateUIView(_ uiView: UIButton, context: Context) {
        // do nothing
    }

    class Coordinator: NSObject, NFCTagReaderSessionDelegate {

        @Binding var tempCoaster:HostCoasterInfo
        @Binding var launchedNfc:Bool
        
        // takes in status code to return to parent
        @Binding var statusCode:Int////        @Binding var launchedNfc:Bool
        // boolean on whether the button has been pressed
        @Binding var pressedButtonToLaunchNfc:Bool


        var session: NFCTagReaderSession?

        init(
             launchedNfc: Binding<Bool>,
             tempCoaster: Binding<HostCoasterInfo>,
             statusCode: Binding<Int>,
             pressedButtonToLaunchNfc: Binding<Bool>) {

            
            _launchedNfc = launchedNfc
            _tempCoaster = tempCoaster
            _statusCode = statusCode
            _pressedButtonToLaunchNfc = pressedButtonToLaunchNfc

        }
//        init(uid: Binding<String>) {
//            _uid = uid
//        }

        // function that fires when button is pressed
        @objc func beginNfcScan(_ sender: Any) {
            self.session = NFCTagReaderSession(pollingOption: .iso14443, delegate: self)
            // this createss nfc alert
            self.session?.alertMessage = "scan the Fonz Coaster"
            print("beginning scan on join party")
            // this begins the alert
            self.session?.begin()
        }
        // function that fires without button
        func launchNfcScanWithoutButton() {
            self.session = NFCTagReaderSession(pollingOption: .iso14443, delegate: self)
            // this createss nfc alert
            self.session?.alertMessage = "scan the Fonz Coaster"
            print("beginning scan on join party")
            // this begins the alert
            self.session?.begin()
        }
        func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
            print("session begun")
            pressedButtonToLaunchNfc = true
            
        }
        func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
            print(Error.self)
            self.launchedNfc = true

        }

        // runs when function read is valid
        func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
            print("got this far")
            // ensures only one coaster present
            if tags.count > 1 {
                print("morethan one ")
                session.alertMessage = "more than one tag detected, please try again"
                session.invalidate()
                self.launchedNfc = true
            }
            // code after coaster scanned
            session.connect(to: tags.first!) { (error: Error?) in
                if nil != error{
                    print("connection failed")
                    session.invalidate(errorMessage: "connection failed")
                    self.launchedNfc = true
                }
                if case let NFCTag.miFare(sTag) = tags.first! {

                    // gets the UID from the coaster
                    let uidFromCoaster = sTag.identifier.map{
                        String(format: "%.2hhx", $0) }.joined()
                    print("UID:" + uidFromCoaster)

                    // note on NFC popup returned to user
                    session.alertMessage = "properly connected!"
                    // creates api instaniation
                    let getCoasterApiCall = GuestApi()
                    // ends nfc session
                    session.invalidate()
                    // gets the coaster info from the api when passing in the uid
                    let coasterDetails = getCoasterApiCall.getCoasterInfo(coasterUid: uidFromCoaster)
                    
                    DispatchQueue.main.async {
//                        self.uid = uidFromCoaster
                        // sets vars to return to user
                        self.launchedNfc = true
                        self.tempCoaster.coasterName = coasterDetails.coaster.name
                        self.tempCoaster.hostName = "host"
//                        self.tempCoaster.hostName = coasterDetails.coaster.displayName
                        self.tempCoaster.sessionId = coasterDetails.session.sessionId
                        self.tempCoaster.uid = uidFromCoaster
                        self.statusCode = coasterDetails.statusCode ?? 404
                    }
                }
            }
        }
    }
}


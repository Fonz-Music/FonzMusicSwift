//
//  LaunchJoinPartyNfc.swift
//  Fonz Music App Clip
//
//  Created by didi on 4/20/21.
//

import Foundation
import SwiftUI
import CoreNFC
import UIKit

extension UIButton {
    open override func draw(_ rect: CGRect) {
        //provide custom style
        self.layer.cornerRadius = .cornerRadiusTasks
        self.layer.masksToBounds = true
    }
    
}


struct LaunchJoinPartyNfcSession: UIViewRepresentable {
    func makeCoordinator() -> LaunchJoinPartyNfcSession.Coordinator {
        return Coordinator(launchedNfc: $launchedNfc, tempCoaster: $tempCoaster, statusCode: $statusCode, pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc)
    }

    
    // temp coaster to update page
    @Binding var tempCoaster:HostCoasterInfo
    // boolean on whether the nfc has finished or not
    @Binding var launchedNfc:Bool
    // takes in status code to return to parent
    @Binding var statusCode:Int
    // boolean on whether the button has been pressed
    @Binding var pressedButtonToLaunchNfc:Bool

    func makeUIView(context: UIViewRepresentableContext<LaunchJoinPartyNfcSession>) -> UIButton {
        
        
        // creates nfcTap icon that can be pressed to launch the nfc as well
        let tapButton = UIButton()
        tapButton.isHidden = true
//        tapButton.setImage(UIImage(named: "tapOne"), for: .normal)
//        tapButton.imageView?.contentMode = .scaleAspectFit
//        tapButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 120, bottom: 120, right: 120)
//        tapButton.addTarget(context.coordinator, action: #selector(context.coordinator.beginNfcScan(_:)), for: .touchUpInside)
//        // prevents the nfc from launching on other pages when the app is loaded
//        if (guestPageNumber == 0) {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                print("launching nfc scan ")
                context.coordinator.launchNfcScanWithoutButton()
//            }
//        }
        return tapButton
    }

    func updateUIView(_ uiView: UIButton, context: Context) {
        // do nothing
    }

    class Coordinator: NSObject, NFCTagReaderSessionDelegate {

        
        // temp coaster to update page
        @Binding var tempCoaster:HostCoasterInfo
        // boolean on whether the nfc has finished or not
        @Binding var launchedNfc:Bool
        // takes in status code to return to parent
        @Binding var statusCode:Int
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


        // function that fires when button is pressed
        @objc func beginNfcScan(_ sender: Any) {
            self.session = NFCTagReaderSession(pollingOption: .iso14443, delegate: self)
            // this createss nfc alert
            self.session?.alertMessage = "Tap the Fonz Coaster"
            print("beginning scan on join party")
            // this begins the alert
            self.session?.begin()
        }
        // function that fires without button
        func launchNfcScanWithoutButton() {
            self.session = NFCTagReaderSession(pollingOption: .iso14443, delegate: self)
            // this createss nfc alert
            self.session?.alertMessage = "Tap the Fonz Coaster"
            print("beginning scan on join party")
            // this begins the alert
            self.session?.begin()
        }

        func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
            print("session begun")
            
            
        }

        func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
            print(Error.self)
            session.invalidate()
            self.statusCode = 0
            self.launchedNfc = true
            self.pressedButtonToLaunchNfc = false
        }

        // runs when function read is valid
        func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
            print("got this far")
            // ensures only one coaster present
            if tags.count > 1 {
                print("morethan one ")
                session.alertMessage = "more than one tag detected, please try again"
                statusCode = 0
                self.launchedNfc = true
                self.pressedButtonToLaunchNfc = false
                session.invalidate()
            }
            // code after coaster scanned
            session.connect(to: tags.first!) { (error: Error?) in
                if nil != error{
                    print("connection failed")
                    session.invalidate(errorMessage: "connection failed")
                    self.launchedNfc = true
                    self.statusCode = 0
                    self.pressedButtonToLaunchNfc = false
                }
                if case let NFCTag.miFare(sTag) = tags.first! {

                    // gets the UID from the coaster
                    let UID = sTag.identifier.map{
                        String(format: "%.2hhx", $0) }.joined()
                    print("UID:" + UID)

                    // note on NFC popup returned to user
                    session.alertMessage = "properly connected!"
                    // creates api instaniation
                    let getCoasterApiCall = GuestApi()
                    // ends nfc session
                    session.invalidate()
                    // gets the coaster info from the api when passing in the uid
                    let coasterDetails = getCoasterApiCall.getCoasterInfo(coasterUid: UID)
                    print("coaster details are \(coasterDetails)")
                    
//                    coasterDetails.session.userId
           
                    DispatchQueue.main.async {
                        // sets vars to return to user
                        self.launchedNfc = true
                        self.tempCoaster.coasterName = coasterDetails.coaster.name
                        self.tempCoaster.hostName = "host"
                        self.tempCoaster.hostUserId = coasterDetails.session.userId
//                        self.tempCoaster.hostName = coasterDetails.coaster.displayName
                        self.tempCoaster.sessionId = coasterDetails.session.sessionId
                        self.tempCoaster.group = coasterDetails.coaster.group ?? "general"
                        self.tempCoaster.uid = UID
                        if coasterDetails.session.provider != "" {
                            self.statusCode = coasterDetails.statusCode!
                        }
                        // if they don't have a provider, host needs to connect to spot
                        else {
                            self.statusCode = 403
                        }
                        
                        self.pressedButtonToLaunchNfc = false
                    }
                }
            }
        }
    }
}

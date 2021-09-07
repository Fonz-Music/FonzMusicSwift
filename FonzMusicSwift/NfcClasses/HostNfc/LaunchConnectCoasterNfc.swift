//
//  LaunchConnectCoasterNfc.swift
//  FonzMusicSwift
//
//  Created by didi on 4/29/21.
//


import Foundation
import SwiftUI
import CoreNFC
import UIKit



struct LaunchConnectCoasterNfc: UIViewRepresentable {
    func makeCoordinator() -> LaunchConnectCoasterNfc.Coordinator {
        return Coordinator(launchedNfc: $launchedNfc, tempCoaster: $tempCoaster, statusCode: $statusCode, pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc)
    }

    
    // temp coaster to update page
    @Binding var tempCoaster:HostCoasterInfo
    // boolean on whether the nfc has finished or not
    @Binding var launchedNfc:Bool
    // takes in status code to return to parent
    @Binding var statusCode:Int
    
    // takes in active page so that the nfc doenst launch by accident
//    @Binding var hostPageNumber:Int
    // boolean on whether the button has been pressed, used
    // to show animation on nfc launch
    @Binding var pressedButtonToLaunchNfc:Bool


    func makeUIView(context: UIViewRepresentableContext<LaunchConnectCoasterNfc>) -> UIButton {
        
        // creates nfcTap icon that can be pressed to launch the nfc as well
        let tapButton = UIButton()
        tapButton.isHidden = true

        if (pressedButtonToLaunchNfc) {
                print("launching nfc scan ")
                context.coordinator.launchNfcScanWithoutButton()
        }
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
            print("beginning scan on connect coaster")
            // this begins the alert
            self.session?.begin()
        }

        func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
            print("session begun")
//            self.pressedButtonToLaunchNfc = false
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
                    self.pressedButtonToLaunchNfc = false
                    self.statusCode = 0
                }
               
                
                if case let NFCTag.miFare(sTag) = tags.first! {

                    // gets the UID from the coaster
                    let coasterUidFromTag = sTag.identifier.map{
                        String(format: "%.2hhx", $0) }.joined()
                    print("UID:" + coasterUidFromTag)
                    

                
                
                    
//                    NFCTag.miFare(sTag.mifareFami)
                    
                    print(session.connectedTag)
                    print(session.connectedTag.publisher)
//                    print(sTag.historicalBytes.map{String(format: "%.2hhx", $0) }.joined())

                    // note on NFC popup returned to user
                    session.alertMessage = "properly connected!"
                    // ends nfc session
                    session.invalidate()
                    // checks to see if the coaster has a host
                    var coasterDetails = HostCoastersApi().getSingleOwnedCoaster(coasterUid: coasterUidFromTag)
                    // checks to see if the coaster has a host
//                    var coasterDetails = GuestApi().getCoasterInfo(coasterUid: coasterUidFromTag)
                    print("\(String(describing: coasterDetails.statusCode)) is the code m8")
                    // in case the coaster belongs to someone else
                    var coasterDetailsOther = GetCoasterInfoGuestResponse(coaster: CoasterResponse(active: false, coasterId: "", name: "", group: "", encoded: false), session: SessionResponse(sessionId: "", userId: "", active: false, provider: ""))
                    // if the coaster does NOT have a host, add to account
                    
//                    else
                    if coasterDetails.statusCode == 404 {
                        coasterDetailsOther = GuestApi().getCoasterInfo(coasterUid: coasterUidFromTag)
                        if coasterDetailsOther.statusCode == 204 {
                            print("addung coaster")
                            let addCoasterResult = HostCoastersApi().addCoaster(coasterUid: coasterUidFromTag)
                            print("\(String(describing: addCoasterResult.status)) is the code m8")
                            // return that resp if its NOT 200
                            if addCoasterResult.status != 200 {
                                coasterDetails.statusCode = addCoasterResult.status
                            }
                            else {
                                coasterDetails.statusCode = 204
                            }
                        }
                        else {
                            print("return value is \(coasterDetailsOther.statusCode)")
                        }
                    }
                    
                    // gets the coaster info from the api when passing in the uid
                    
//                    print("coaster details are \(addCoasterResult)")
           
                    DispatchQueue.main.async {
                        // sets vars to return to user
                        self.tempCoaster.uid = coasterUidFromTag
                        if coasterDetails.statusCode == 200 {
                            self.tempCoaster.coasterName = coasterDetails.name
                            self.tempCoaster.hostName = "host"
    //                        self.tempCoaster.hostName = coasterDetails.coaster.displayName
                        }
                        else if coasterDetailsOther.statusCode == 200 {
                            print("someone else's coaster")
                            self.tempCoaster.coasterName = coasterDetailsOther.coaster.name
                            self.tempCoaster.hostName = "host"
                            coasterDetails.statusCode = 403
    //                        self.tempCoaster.hostName = coasterDetails.coaster.displayName
                        }
                        self.launchedNfc = true
                        self.statusCode = coasterDetails.statusCode!
//                        self.statusCode = 403
                        self.pressedButtonToLaunchNfc = false
                    }
                }
            }
        }
    }
}

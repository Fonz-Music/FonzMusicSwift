//
//  SpotifyViewRep.swift
//  FonzMusicSwift
//
//  Created by didi on 5/1/21.
//

import Foundation
import UIKit
import SwiftUI

struct LaunchSpotifyWebview: UIViewControllerRepresentable {
    
    var controller: UIViewController
    
    func makeUIViewController(context: Context) -> SpotifyWebViewWk {
        // make it
        let webby = SpotifyWebViewWk()
        
        webby.controller = controller
        
        controller.present(webby, animated: true, completion: nil)
        webby.openURL(userToken: "sdsfsddsbsafdsf")
        
        return webby
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // launch it?
    }
    
    typealias UIViewControllerType = SpotifyWebViewWk
    
    
    
}

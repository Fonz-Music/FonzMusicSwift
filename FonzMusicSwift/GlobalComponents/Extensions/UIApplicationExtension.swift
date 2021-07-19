//
//  UIApplicationExtension.swift
//  FonzMusicSwift
//
//  Created by didi on 7/18/21.
//

import Foundation
import SwiftUI

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
}

extension UIApplication {
       class func isFirstLaunch() -> Bool {
           if !UserDefaults.standard.bool(forKey: "hasBeenLaunchedBeforeFlag") {
               UserDefaults.standard.set(true, forKey: "hasBeenLaunchedBeforeFlag")
               UserDefaults.standard.synchronize()
               return true
           }
           return false
       }
   }

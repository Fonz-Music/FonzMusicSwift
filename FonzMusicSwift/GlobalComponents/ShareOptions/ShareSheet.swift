//
//  ShareSheet.swift
//  FonzMusicSwift
//
//  Created by didi on 5/31/21.
//

import Foundation
import UIKit
import SwiftUI

func shareButton(urlToShare:String) {
    let url = URL(string: urlToShare)
    let activityController = UIActivityViewController(activityItems: [url!], applicationActivities:nil)
    
    UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
}

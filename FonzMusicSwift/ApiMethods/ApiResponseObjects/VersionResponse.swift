//
//  VersionResponse.swift
//  FonzMusicSwift
//
//  Created by didi on 6/30/21.
//

import Foundation
import SwiftUI

struct VersionResponse: Codable {
    var apiVersion: CGFloat
    var minimumAppVersion: String
}

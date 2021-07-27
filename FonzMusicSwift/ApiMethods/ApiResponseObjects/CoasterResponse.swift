//
//  CoasterResponse.swift
//  FonzMusicSwift
//
//  Created by didi on 7/27/21.
//

import Foundation

struct CoasterResponse: Codable {
    var active: Bool
    var coasterId: String
    var name: String
//    var displayName: String
    var statusCode: Int?
}

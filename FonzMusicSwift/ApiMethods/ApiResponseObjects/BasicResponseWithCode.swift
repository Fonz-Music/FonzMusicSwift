//
//  BasicResponseWithCode.swift
//  FonzMusicSwift
//
//  Created by didi on 7/25/21.
//

import Foundation

struct BasicResponseWithCode: Codable {
    var message: String
    var status: Int
    var code: String
}

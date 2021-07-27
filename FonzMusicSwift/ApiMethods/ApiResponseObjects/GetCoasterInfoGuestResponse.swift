//
//  GetCoasterInfoGuestResponse.swift
//  FonzMusicSwift
//
//  Created by didi on 7/27/21.
//

import Foundation

struct GetCoasterInfoGuestResponse : Codable {
    var coaster : CoasterResponse
    var session : SessionResponse
    var statusCode: Int?
}

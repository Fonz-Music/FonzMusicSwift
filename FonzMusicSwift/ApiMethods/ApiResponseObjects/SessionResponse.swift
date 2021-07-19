//
//  SessionReponse.swift
//  FonzMusicSwift
//
//  Created by didi on 7/19/21.
//

import Foundation

struct SessionResponse: Codable {
    var active : Bool
    var authenticationId : String
    var provider : String
    var sessionId : String
}

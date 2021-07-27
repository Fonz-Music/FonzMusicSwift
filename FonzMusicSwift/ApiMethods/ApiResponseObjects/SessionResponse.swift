//
//  SessionReponse.swift
//  FonzMusicSwift
//
//  Created by didi on 7/19/21.
//

import Foundation

struct SessionResponse: Codable {
    var sessionId : String
    var userId : String
    var active : Bool
    var provider : String
    
    
}

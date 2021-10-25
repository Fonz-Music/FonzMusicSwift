//
//  SearchPageFunctions.swift
//  FonzMusicSwift
//
//  Created by didi on 10/2/21.
//

import Foundation

func queueSongToHostSession(sessionId : String, trackId : String) -> Int {
    
    var statusCode : Int
    
    let previousSongQueued = UserDefaults.standard.string(forKey: "previousSongQueued") ?? ""
    
    if trackId != previousSongQueued {
      statusCode = GuestApi().queueSong(sessionId: sessionId, trackId: trackId)
        
    }
    else {
        statusCode = 601
    }
    
    return statusCode
    
}

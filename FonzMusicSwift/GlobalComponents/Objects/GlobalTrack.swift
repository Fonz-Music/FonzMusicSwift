//
//  GlobalTrack.swift
//  FonzMusicSwift
//
//  Created by didi on 4/27/21.
//

import Foundation

// Object that includes all attributes for a Track, passed from songSearch to queueSong pages
class GlobalTrack: ObservableObject {
    @Published var songName = ""
    @Published var songId = ""
    @Published var artistName = ""
    @Published var albumArt = ""
    @Published var songLoaded = false
}

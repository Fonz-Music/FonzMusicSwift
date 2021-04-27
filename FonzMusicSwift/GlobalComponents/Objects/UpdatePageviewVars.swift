//
//  UpdatePageviewVars.swift
//  FonzMusicSwift
//
//  Created by didi on 4/27/21.
//

import Foundation

// Object to tell App to update page based on new info (like selecting a song or tapping coaster)
// includes what page it should be updated to
class UpdatePageViewVariables: ObservableObject {
    @Published var updatePageReverse = false
}

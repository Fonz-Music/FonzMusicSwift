//
//  HostCoasterInfo.swift
//  FonzMusicSwift
//
//  Created by didi on 4/27/21.
//

import Foundation

// Object that has all attributes for the current Host coaster
class HostCoasterInfo: ObservableObject {
    @Published var uid = ""
    @Published var hostName = ""
    @Published var coasterName = ""
    @Published var sessionId = ""
}

struct CoasterInfo: Hashable {
    var uid: String
    var hostName: String
    var coasterName: String
    var sessionId: String
    var active: Bool?
}

struct CoasterResult: Codable {
    var sessionId: String
    var displayName: String
    var coasterName: String
    var statusCode: Int?
}

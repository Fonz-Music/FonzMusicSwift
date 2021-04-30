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

struct CoasterInfo: Hashable, Codable {
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
    var coasterActive: Bool
    var coasterPaused: Bool
    var statusCode: Int?
}

struct HostCoasterResult: Codable, Hashable {
    var active: Bool
    var coasterId: String
    var name: String
    var paused: Bool
}
//struct HostCoastersArray:Codable {
//    var coasters: Array<HostCoasterResult>
//}
struct HostCoastersMapResult: Codable {
    var coasters: Array<HostCoasterResult>
    var quantity: Int
}

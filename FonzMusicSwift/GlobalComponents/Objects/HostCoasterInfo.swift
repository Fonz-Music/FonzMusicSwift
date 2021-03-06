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
    var hostUserId = ""
    var group = ""
    var encoded = false
}

struct CoasterInfo: Hashable, Codable {
    var uid: String
    var hostName: String
    var coasterName: String
    var sessionId: String
    var active: Bool?
    
//    func toHostCoasterResult() -> HostCoasterResult {
//        let newHostCoasterResult = HostCoasterResult(
//            active: self.active ?? true,
//            coasterId: self.uid,
//            name: self.coasterName
//            )
//        return newHostCoasterResult
//    }
}



struct HostCoasterResult: Codable, Hashable {
    var active: Bool
    var coasterId: String
    var name: String
    var group: String?
    var encoded: Bool
    
    
    func toCoasterInfo() -> CoasterInfo {
        let newCoasterInfo = CoasterInfo(
            uid: self.coasterId,
            hostName: "",
            coasterName: self.name,
            sessionId: ""
            )
        return newCoasterInfo
    }
}
//struct HostCoastersArray:Codable {
//    var coasters: Array<HostCoasterResult>
//}
struct HostCoastersMapResult: Codable {
    var coasters: Array<HostCoasterResult>
    var quantity: Int
}

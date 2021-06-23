//
//  URL.swift
//  FonzMusicSwift
//
//  Created by didi on 6/23/21.
//

import Foundation



extension URL {
  var isDeeplink: Bool {
    return scheme == "fonz-music" // matches my-url-scheme://<rest-of-the-url>
  }

  var tabIdentifier: TabIdentifier? {
    guard isDeeplink else { return nil }

    switch host {
    case "host": return .host // matches my-url-scheme://home/
    case "search": return .search // matches my-url-scheme://search/
    case "settings": return .settings // matches my-url-scheme://settings/
    default: return nil
    }
  }
}


extension URL {
  var isDeep: Bool {
    return scheme == "www.fonzmusic.com" // matches my-url-scheme://<rest-of-the-url>
  }

  var checksCoaster: String? {
    guard isDeep else { return nil }
    
    var uuid : UUID
    
    
              uuid = UUID(uuidString: pathComponents[1])! 

    let coasterUid = uuid.uuidString
    print("\(coasterUid)")
   
    
    return coasterUid
  }
}

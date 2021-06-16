//
//  SearchTab.swift
//  FonzMusicSwift
//
//  Created by didi on 6/15/21.
//

import SwiftUI

struct SearchTab: View {
    
    @State var hasHost = false
    @State var hostCoaster = HostCoasterInfo()
   
    
    var body: some View {
        if hasHost {
            SearchBar(hostCoaster: hostCoaster, hasHostVar: $hasHost)
        }
        else {
            HomePageDecision(hostCoaster: hostCoaster, hasHostVar: $hasHost)
        }
    }
}

//
//  SearchTab.swift
//  FonzMusicSwift
//
//  Created by didi on 6/15/21.
//

import SwiftUI

struct SearchTab: View {
    
    @State var hasHost = false
    var hostCoaster = HostCoasterInfo()
    
    var body: some View {
        if hasHost {
            SearchBar(hostCoaster: hostCoaster)
        }
        else {
            HomePageDecision()
        }
    }
}

struct SearchTab_Previews: PreviewProvider {
    static var previews: some View {
        SearchTab()
    }
}

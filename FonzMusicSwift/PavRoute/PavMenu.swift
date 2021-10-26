//
//  PavMenue.swift
//  FonzMusicSwift
//
//  Created by didi on 10/26/21.
//

import SwiftUI

struct PavMenu: View {
    
    @State var onDrinksMenu : Bool = true
    
    var body: some View {
        VStack{
            PavMenuHeader()
            PavMenuDrinksOrFood(onDrinksMenu: $onDrinksMenu)
            Spacer()
        }
        .background(
            Color(.white)
        )
        .ignoresSafeArea()
    }
}

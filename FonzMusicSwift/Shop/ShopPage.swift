//
//  ShopPage.swift
//  FonzMusicSwift
//
//  Created by didi on 11/19/21.
//

import SwiftUI

struct ShopPage: View {
    
    @Binding var launchShopModal : Bool
    
    var body: some View {
        VStack{
            ShopHeader(launchShopModal: $launchShopModal)
            ShopItems()
            Spacer()
        }
        .background(
            Image("newColorfulBgVertical")
                .resizable()
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
            , alignment: .bottom)
        .ignoresSafeArea()
    }
}

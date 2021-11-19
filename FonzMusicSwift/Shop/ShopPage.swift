//
//  ShopPage.swift
//  FonzMusicSwift
//
//  Created by didi on 11/19/21.
//

import SwiftUI
import Stripe

struct ShopPage: View {
    
    @Binding var launchShopModal : Bool
    
//    init(
//    StripeAPI.
//    StripeAPI.defaultPublishableKey = "pk_live_51HCTMlKULAGg50zbqXd9cf5sIUrKrRwHQFBLbTLv56947KWQheJX3nXTNl6H8WTPzm6mVKYlEaYvLg2SyjGKBNio00T4W00Hap"
//    )
    
    
    var body: some View {
        VStack{
            ShopHeader(launchShopModal: $launchShopModal)
            Spacer()
                .frame(height: 60)
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

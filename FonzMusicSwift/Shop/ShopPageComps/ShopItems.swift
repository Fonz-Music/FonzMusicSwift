//
//  ShopItems.swift
//  FonzMusicSwift
//
//  Created by didi on 11/19/21.
//

import SwiftUI

struct ShopItems: View {
//    var shopItemList : Array<ItemFromShop>
    
    var shopItemList : Array<ItemFromShop> = [
        ItemFromShop(title: "hangout host", package: "afsgdf", info: "single fonz coaster", price: 10, image: "https://fonzmusic.com/img/coasterMockupPng.a1fe7f43.png", details: "100% waterproof & lightweight. allow your friends to queue songs whenever you're together!"),
        ItemFromShop(title: "solo host", package: "hngfysd", info: "double fonz coaster", price: 20, image: "https://fonzmusic.com/img/coasterMockupPng.a1fe7f43.png", details: "100% waterproof & lightweight. allow your friends to queue songs whenever you're together!"),
        ItemFromShop(title: "hangout host", package: "afsgdf", info: "single fonz coaster", price: 10, image: "https://fonzmusic.com/img/coasterMockupPng.a1fe7f43.png", details: "100% waterproof & lightweight. allow your friends to queue songs whenever you're together!")
    ]
    
//    let layout = [
//            GridItem(.flexible())
//        ]
    @State private var selection: Set<ItemFromShop> = []
    
    var body: some View {
        VStack{
            ForEach(shopItemList, id: \.self) { item in
                ShopItem(itemFromShop: item, isExpanded: self.selection.contains(item))
                    .onTapGesture {
                        withAnimation {
                            self.selectDeselect(item)
                        }
                        
                        
                    }
            }
        }
    }
    
    private func selectDeselect(_ coaster: ItemFromShop) {
            if selection.contains(coaster) {
                selection.remove(coaster)
            } else {
                selection.insert(coaster)
            }
        }
}

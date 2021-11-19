//
//  ShopItems.swift
//  FonzMusicSwift
//
//  Created by didi on 11/19/21.
//

import SwiftUI

struct ShopItems: View {
    var shopItemList : Array<ItemFromShop> = ItemsFromWebApi().products
    
    @State var cartId : String = ""
    @State var packageId : String = ""
    
    let layout = [
            GridItem(.flexible())
        ]
    @State private var selection: Set<ItemFromShop> = []
    
    var body: some View {
        VStack{
            ScrollView(showsIndicators: true) {
                LazyVGrid(columns: layout, spacing: 5) {
                   ForEach(shopItemList, id: \.self) { item in
                       ShopItem(itemFromShop: item, isExpanded: self.selection.contains(item), cartId: cartId)
                            .onTapGesture {
                                withAnimation {
                                    self.selectDeselect(item)
                                }
                                packageId = item.package
                                if (cartId == "") {
                                    // create a cart
                                    cartId = FonzShopApi().createFonzShopCart(packageId: packageId, currency: "eur")
                                }
                                
                            }
                    }
                }
                Spacer()
                    .frame(minHeight: 60)
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

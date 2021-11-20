//
//  ItemFromShop.swift
//  FonzMusicSwift
//
//  Created by didi on 11/19/21.
//

import Foundation

struct ItemFromShop: Codable, Hashable {
    var title: String
    var package: String
    var info: String
    var price: Float
    var image: String
    var details: String
    var quantity: Int
}

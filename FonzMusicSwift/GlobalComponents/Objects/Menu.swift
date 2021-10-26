//
//  PavMenuData.swift
//  FonzMusicSwift
//
//  Created by didi on 10/25/21.
//


struct Menu: Hashable, Decodable {
    var drinks: DrinksMenu
//    var food: FoodMenu
}
struct DrinksMenu: Hashable, Decodable {
    var beer: Array<Beer>
    var wine: Array<Wine>
    var cocktails: Array<Cocktail>
    var soda: Array<Soda>
    var hotDrinks: Array<HotDrinks>
}
struct Beer: Hashable, Decodable {
    var name: String
    var price: Float
    var country: String?
}
struct Wine: Hashable, Decodable {
    var name: String
    var price: Float
    var color: String?
}
struct Cocktail: Hashable, Decodable {
    var name: String
    var price: Float
    var ingredients: Array<String>?
}
struct Soda: Hashable, Decodable {
    var name: String
    var price: Float
    var container: String?
}

struct HotDrinks: Hashable, Decodable {
    var name: String
    var price: Float
//    var container: String?
}

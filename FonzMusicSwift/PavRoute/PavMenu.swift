//
//  PavMenue.swift
//  FonzMusicSwift
//
//  Created by didi on 10/26/21.
//

import SwiftUI

struct PavMenu: View {
    
    @State var onDrinksMenu : Bool = true
    @State var activeDrink : ActiveDrink = ActiveDrink.beer
    
    var pavMenu = Menu(drinks:
        DrinksMenu(
            beer: [
                Beer(name: "Heinekin", price: 4.8),
                Beer(name: "Guinness", price: 4.8),
                Beer(name: "Carlsberg", price: 4.8),
                Beer(name: "Hop House", price: 4.8),
                Beer(name: "Pratsky 4-Pack", price: 10),
                Beer(name: "Bulmers", price: 4.8),
            
            ],
            wine: [
                Wine(name: "Chardonay", price: 4.8, color: "White"),
                Wine(name: "Pinot Noir", price: 4.8, color: "Red"),
                Wine(name: "Pinot Grigio", price: 4.8, color: "White"),
                Wine(name: "Rosé", price: 4.8, color: "Pink"),
                Wine(name: "White Zinfindal", price: 4.8, color: "Pink"),
            ],
            cocktails: [
                Cocktail(name: "Sex on the Beach", price: 4.8),
                Cocktail(name: "White Russian", price: 4.8),
                Cocktail(name: "Dirty Shirley", price: 4.8),
                Cocktail(name: "Jack & Coke", price: 4.8),
                Cocktail(name: "Jameson & Ginger", price: 4.8),
            ],
            soda: [
                Soda(name: "Coke", price: 3.0, container: "Bottle"),
                Soda(name: "Sprite", price: 3.0, container: "Bottle"),
                Soda(name: "Fanta Orange", price: 3.0, container: "Bottle"),
                Soda(name: "Fanta Lemon", price: 3.0, container: "Bottle"),
                Soda(name: "Mineral Water", price: 2.5, container: "Bottle"),
                Soda(name: "Juice", price: 3.1, container: "Bottle"),
                Soda(name: "Pint of Cordial", price: 1.0, container: "Glass"),
            ],
            hotDrinks: [
                HotDrinks(name: "Espresso", price: 1.9),
                HotDrinks(name: "Pot of Tea", price: 2.2),
                HotDrinks(name: "Pot of Coffee", price: 2.4),
                HotDrinks(name: "Americano", price: 2.4),
                HotDrinks(name: "Cappuccino", price: 2.7),
                HotDrinks(name: "Latte", price: 2.7),
                HotDrinks(name: "Flat White", price: 2.7),
                HotDrinks(name: "Hot Chocolate", price: 3.2),
                HotDrinks(name: "Mocha", price: 3.1),
            ]))
    
    var body: some View {
        ScrollView {
            VStack{
                PavMenuHeader()
                PavMenuDrinksOrFood(onDrinksMenu: $onDrinksMenu)
                if onDrinksMenu {
                    PavDrinksMenu(drinksMenu: pavMenu.drinks, activeDrink: $activeDrink)
                }
                
                Spacer()
            }
        }
        .background(
            Color(.white)
        )
        .ignoresSafeArea()
        
    }
}

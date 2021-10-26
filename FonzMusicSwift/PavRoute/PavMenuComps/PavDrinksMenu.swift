//
//  PavDrinksMenu.swift
//  FonzMusicSwift
//
//  Created by didi on 10/26/21.
//

import SwiftUI

enum ActiveDrink {
    case beer
    case wine
    case cocktails
    case soda
    case hotDrinks
}


struct PavDrinksMenu: View {
    
    var drinksMenu : DrinksMenu
    @Binding var activeDrink : ActiveDrink
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack(spacing:5) {
                    ItemTypeButton(itemName: "Beer", activeDrink: $activeDrink)
                    ItemTypeButton(itemName: "Wine", activeDrink: $activeDrink)
                    ItemTypeButton(itemName: "Soda", activeDrink: $activeDrink)
                    ItemTypeButton(itemName: "Cocktails", activeDrink: $activeDrink)
                    ItemTypeButton(itemName: "Hot Drinks", activeDrink: $activeDrink)
                }
                .padding(5)
            }
            switch activeDrink {
            case .beer:
                PavBeerMenu(beerList: drinksMenu.beer)
                
            case .wine:
                Text("wine")
                
            case .cocktails:
                Text("wine")
                
            case .soda:
                Text("wine")
                
            case .hotDrinks:
                Text("wine")
                
            default:
                PavBeerMenu(beerList: drinksMenu.beer)
                
            }
        }
    }
}

struct ItemTypeButton: View {
    
    var itemName : String
    @Binding var activeDrink : ActiveDrink
    
    func determineIfItemIsActive() -> Bool {
        if (
            (itemName == "Beer" && activeDrink == .beer) ||
            (itemName == "Wine" && activeDrink == .wine) ||
            (itemName == "Soda" && activeDrink == .soda) ||
            (itemName == "Cocktails" && activeDrink == .cocktails) ||
            (itemName == "Hot Drinks" && activeDrink == .hotDrinks)
        ) {
            return true
        }
        else {
            return false
        }
    }
    
    var body: some View {
        Button {
            switch itemName {
            case "Beer":
                activeDrink = .beer
                break
            case "Wine":
                activeDrink = .wine
            case "Soda":
                activeDrink = .soda
            case "Cocktails":
                activeDrink = .cocktails
            case "Hot Drinks":
                activeDrink = .hotDrinks
            default:
                activeDrink = .beer
            }
            
        } label: {
            Text(itemName)
                .foregroundColor(determineIfItemIsActive() ? .gray : .yellow)
                .fonzParagraphTwo()
                .padding(10)
        }
        .buttonStyle(BasicFonzButton(bgColor: determineIfItemIsActive() ? .yellow : .darkButton, secondaryColor: .yellow))
        .frame(minWidth: 75)
    }
}

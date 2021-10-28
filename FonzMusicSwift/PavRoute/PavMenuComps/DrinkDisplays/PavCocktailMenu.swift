//
//  PavCocktailMenu.swift
//  FonzMusicSwift
//
//  Created by didi on 10/26/21.
//

import SwiftUI

struct PavCocktailMenu: View {
    var cocktailList : Array<Cocktail>
    
    var body: some View {
        VStack{
            ForEach(cocktailList, id: \.self) { cocktail in
                Button(action: {
                    print("Selected \(cocktail.name)")
                }, label: {
                    VStack {
                        HStack {
                            Text(cocktail.name)
                                .foregroundColor(.darkButton)
                                .fonzParagraphOne()
                                .padding(5)
                            Spacer()
                            Text("\(cocktail.price, specifier: "%.2f")")
                                .foregroundColor(.darkButton)
                                .fonzHeading()
                                .padding(5)
                        }
                        if cocktail.ingredients?.count != 0 {
//                            Text(String(cocktail.ingredients?) ?? "Glass")
//                                .foregroundColor(.darkButton)
//                                .fonzParagraphTwo()
                        }
                       
                        
                    }
                })
                    .buttonStyle(BasicFonzButton(bgColor: Color.white, secondaryColor: .yellow))
                    .padding()
                
                
            }
        }
    }
}

//
//  PavHotDrinkMenu.swift
//  FonzMusicSwift
//
//  Created by didi on 10/26/21.
//

import SwiftUI

struct PavHotDrinkMenu: View {
    var hotDrinkList : Array<HotDrinks>
    
    var body: some View {
        VStack{
            ForEach(hotDrinkList, id: \.self) { drink in
                Button(action: {
                    print("Selected \(drink.name)")
                }, label: {
                    VStack {
                        HStack {
                            Text(drink.name)
                                .foregroundColor(.darkButton)
                                .fonzParagraphOne()
                                .padding(5)
                            Spacer()
                            Text(String(drink.price))
                                .foregroundColor(.darkButton)
                                .fonzHeading()
                                .padding(5)
                        }
                        
                    }
                })
                    .buttonStyle(BasicFonzButton(bgColor: Color.white, secondaryColor: .yellow))
                    .padding()
                
                
            }
        }
    }
}

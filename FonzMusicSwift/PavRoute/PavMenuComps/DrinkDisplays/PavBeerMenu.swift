//
//  PavBeerMenu.swift
//  FonzMusicSwift
//
//  Created by didi on 10/26/21.
//

import SwiftUI

struct PavBeerMenu: View {
    
    var beerList : Array<Beer>
    
    var body: some View {
        VStack{
            ForEach(beerList, id: \.self) { beer in
                Button(action: {
                    print("Selected \(beer.name)")
                }, label: {
                    VStack {
                        HStack {
                            Text(beer.name)
                                .foregroundColor(.darkButton)
                                .fonzParagraphOne()
                                .padding(5)
                            Spacer()
                            Text("\(beer.price, specifier: "%.2f")")
                                .foregroundColor(.darkButton)
                                .fonzHeading()
                                .padding(5)
                        }
                        if beer.country != nil || beer.country != "" {
                            Text(beer.country ?? "Domestic")
                                .foregroundColor(.darkButton)
                                .fonzParagraphTwo()
                        }
                    }
                })
                    .buttonStyle(BasicFonzButton(bgColor: Color.white, secondaryColor: .yellow))
                    .padding()
                
                
            }
        }
    }
}

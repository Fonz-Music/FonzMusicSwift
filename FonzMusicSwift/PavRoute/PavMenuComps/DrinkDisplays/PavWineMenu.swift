//
//  PavWineMenu.swift
//  FonzMusicSwift
//
//  Created by didi on 10/26/21.
//

import SwiftUI

struct PavWineMenu: View {
    var wineList : Array<Wine>
    
    var body: some View {
        VStack{
            ForEach(wineList, id: \.self) { wine in
                Button(action: {
                    print("Selected \(wine.name)")
                }, label: {
                    VStack {
                        HStack {
                            Text(wine.name)
                                .foregroundColor(.darkButton)
                                .fonzParagraphOne()
                                .padding(5)
                            Spacer()
                            Text("\(wine.price, specifier: "%.2f")")
                                .foregroundColor(.darkButton)
                                .fonzHeading()
                                .padding(5)
                        }
                       
                        Text(wine.color ?? "Mix")
                            .foregroundColor(.darkButton)
                            .fonzParagraphTwo()
                        
                    }
                })
                    .buttonStyle(BasicFonzButton(bgColor: Color.white, secondaryColor: .yellow))
                    .padding()
                
                
            }
        }
    }
}

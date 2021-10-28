//
//  PavSodaMenu.swift
//  FonzMusicSwift
//
//  Created by didi on 10/26/21.
//

import SwiftUI

struct PavSodaMenu: View {
    var sodaList : Array<Soda>
    
    var body: some View {
        VStack{
            ForEach(sodaList, id: \.self) { soda in
                Button(action: {
                    print("Selected \(soda.name)")
                }, label: {
                    VStack {
                        HStack {
                            Text(soda.name)
                                .foregroundColor(.darkButton)
                                .fonzParagraphOne()
                                .padding(5)
                            Spacer()
                            Text("\(soda.price, specifier: "%.2f")")
                                .foregroundColor(.darkButton)
                                .fonzHeading()
                                .padding(5)
                        }
                       
                        Text(soda.container ?? "Glass")
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

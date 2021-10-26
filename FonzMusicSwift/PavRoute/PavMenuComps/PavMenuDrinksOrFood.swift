//
//  PavMenuDrinksOrFood.swift
//  FonzMusicSwift
//
//  Created by didi on 10/26/21.
//

import SwiftUI

struct PavMenuDrinksOrFood: View {
    
    @Binding var onDrinksMenu : Bool
    
    var body: some View {
        HStack{
            Spacer()
            Button {
                withAnimation {
                    onDrinksMenu = true
                }
                
            } label: {
                Text("Drinks")
                    .addUnderline(active: onDrinksMenu, color: .yellow)
                    .foregroundColor(Color.gray)
                    .fonzParagraphOne()
                    .padding(.horizontal)
                
            }
            Button {
                withAnimation {
                    onDrinksMenu = false
                }
            } label: {
                Text("Food")
                    .addUnderline(active: !onDrinksMenu, color: .yellow)
                    .foregroundColor(Color.gray)
                    .fonzParagraphOne()
                    .padding(.horizontal)
                
            }
            Spacer()
            

        }
        .padding(5)
    }
}

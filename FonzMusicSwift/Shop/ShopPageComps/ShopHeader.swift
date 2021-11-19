//
//  ShopHeader.swift
//  FonzMusicSwift
//
//  Created by didi on 11/19/21.
//

import SwiftUI

struct ShopHeader: View {
    
    @Binding var launchShopModal : Bool
    
    var body: some View {
        HStack{
            Text("fonz shop")
                .foregroundColor(Color.white)
                .fonzParagraphOne()
                .padding(.leading, .headingFrontIndent)
                .padding(.trailing, 5)
            Spacer()
            Button {
                withAnimation {
                    launchShopModal = false
                }
            } label: {
                Text("return")
                    .foregroundColor(Color.black)
                    .fonzParagraphTwo()
                    
            }
            .padding(.trailing, .headingFrontIndent)
        }.padding(.top, .headingTopIndent)
    }
}

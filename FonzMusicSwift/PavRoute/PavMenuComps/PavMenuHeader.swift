//
//  PavMenuHeader.swift
//  FonzMusicSwift
//
//  Created by didi on 10/26/21.
//

import SwiftUI

struct PavMenuHeader: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack{
            Image("pavPic")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .padding(10)
            Text("Menu")
                .foregroundColor(.darkButton)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                .fonzHeading()
                .lineLimit(2)
            Spacer()
        }
    }
}

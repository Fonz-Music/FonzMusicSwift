//
//  QueueDeviceIssue.swift
//  FonzMusicSwift
//
//  Created by didi on 9/6/21.
//

import SwiftUI

struct QueueDeviceIssue: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            HStack{
                ZStack{
                    
                    Image(systemName: "minus")
                        .foregroundColor(.white)
                        .frame(width: 30 , height: 30, alignment: .center)
                }.background(
                    RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                        .fill(Color.amber)
                        .frame(width: 60, height: 60)
                )
                .frame(width: 60, height: 60)
                
                    
                Text("are you using Sonos? we're having issues connecting.")
                    .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                    .fonzButtonText()
                    .padding(.horizontal, 5)
                Spacer()
            }.padding(.vertical)
            
        }.frame(width: UIScreen.screenWidth * 0.9, height: 60)
}
}


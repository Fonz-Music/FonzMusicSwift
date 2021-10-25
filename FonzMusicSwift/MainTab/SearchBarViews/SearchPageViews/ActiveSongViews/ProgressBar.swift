//
//  ProgressBar.swift
//  FonzMusicSwift
//
//  Created by didi on 7/31/21.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var value: Double
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        let progressLength = ((CGFloat(self.value) / 10 ) * (UIScreen.screenWidth * 0.6))
        
            ZStack(alignment: .leading) {
                // background bar
                Rectangle().frame(width: UIScreen.screenWidth * 0.6, height: 5)
                    .opacity(0.3)
                    .foregroundColor(colorScheme == .light ? Color.gray: Color.white)
                // active bar
                Rectangle().frame(width: progressLength, height: 5)
                    .foregroundColor(.lilac)
                    .animation(.linear)
            }.cornerRadius(.cornerRadiusTasks)
        }
}

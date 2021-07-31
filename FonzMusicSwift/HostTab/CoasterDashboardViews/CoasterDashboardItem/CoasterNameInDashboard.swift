//
//  CoasterNameInDashboard.swift
//  FonzMusicSwift
//
//  Created by didi on 6/25/21.
//

import SwiftUI

struct CoasterNameInDashboard: View {
    
    
    
    // the song passed in
    let item: HostCoasterResult
    var isExpanded: Bool
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        // top line
        if isExpanded {
                HStack{
                    // coaster bane
                    Text(verbatim: item.name)
                        .foregroundColor(.white)
                        .fonzParagraphTwo()
                        .padding(.leading, 20)
                    Spacer()
                    Image("coasterIconAlwaysWhite").resizable()
                        .frame( width: 35 ,height: 25).padding(.horizontal, 15)
                }
                .background(
                    RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                        .fill(LinearGradient(
                            gradient: .init(colors: [.lilac, Color.lilacDark]),
                            startPoint: .topLeading,
                              endPoint: .bottomTrailing
                            ))
                        .frame(height: 50)
                )
                .frame(height: 50)
        }
        else {
            HStack(spacing: 10) {
                // coaster w lilac gradiant
                ZStack{
                    
                    Image("coasterIconAlwaysWhite").resizable()
                        .frame( width: 35 ,height: 25).padding(5)
                }
                .background(
                    RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                        .fill(LinearGradient(
                            gradient: .init(colors: [.lilac, Color.lilacDark]),
                            startPoint: .topLeading,
                              endPoint: .bottomTrailing
                        )).frame(width: 50, height: 50)
                )
                .frame( width: 50, height: 50)
                
                // coaster bane
                Text(verbatim: item.name)
                    .foregroundColor(colorScheme == .light ? Color.darkButton: Color.white)
                    .fonzParagraphTwo()
                Spacer()
            }.frame(height: 50)
        
        }
        
    }
}

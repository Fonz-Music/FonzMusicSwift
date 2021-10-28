//
//  QueueASongPubButton.swift
//  FonzMusicSwift
//
//  Created by didi on 10/28/21.
//

import SwiftUI

struct QueueASongPubButton: View {
    
    @Binding var showQueuePage : Bool
    
    var body: some View {
        Button {
            withAnimation{
                showQueuePage = true
            }
                
            
            
//                    throwPavMenuModal = true
            print("pressed")
        } label: {
            HStack{
//                Spacer()
                Image("fonzLogoF")
                    
                    .resizable()
                    .frame(width: 35, height: 75, alignment: .center)
                    .foregroundColor(.white)
                
                    .padding(.leading, 25)
                Spacer()
                Text("queue a song")
                    .foregroundColor(.white)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .fonzParagraphOne()
                    .lineLimit(2)
                Spacer()
            }
        }
        .padding(.horizontal, .subHeadingFrontIndent)
        .frame(width: UIScreen.screenWidth, height: 150, alignment: .center)
        .background(
            RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                .fill(.clear)
                .background(
                    Image("newColorfulBg")
                        .resizable()
                )
                .clipped()
                .padding(.horizontal, .subHeadingFrontIndent)
                .frame(width: UIScreen.screenWidth, height: 150, alignment: .center)
                
                .fonzShadow()
        )
        
        .padding(.vertical, 10)
    }
}


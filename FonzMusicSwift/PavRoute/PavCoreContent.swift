//
//  PavCoreContent.swift
//  FonzMusicSwift
//
//  Created by didi on 10/25/21.
//

import SwiftUI

struct PavCoreContent: View {
    // hostCoaster details passed in and will update view when changed
    @StateObject var hostCoaster:HostCoasterInfo
    // checks if guest has a host
    @Binding var hasHostVar : Bool
    
    // has user download full app if on app clip
    @State var throwPavMenuModal = false
    
    // gets dark/light mode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack{
            PavHeader(hasHostVar: $hasHostVar)
            
            Button {
                throwPavMenuModal = true
                print("pressed")
            } label: {
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
            .background(
                RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                    .fill(.white)
                    .padding(.horizontal, .subHeadingFrontIndent)
                    .frame(width: UIScreen.screenWidth, height: 200, alignment: .center)
                    .fonzShadow()
            )
            .padding(40)
            
            
           
            
            Spacer()
                .frame(height: 30)
        }
        .sheet(isPresented: $throwPavMenuModal) {
            PavMenu()
        }
        
        .ignoresSafeArea()
    }
}

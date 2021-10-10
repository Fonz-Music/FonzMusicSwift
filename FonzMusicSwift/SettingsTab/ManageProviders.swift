//
//  ManageProviders.swift
//  FonzMusicSwift
//
//  Created by didi on 10/10/21.
//

import SwiftUI

struct ManageProviders: View {
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    
    @State var isExpanded = false
    
    @State var providers = [Provider]()
    
    let layout = [
            GridItem(.flexible())
        ]
    
    @Environment(\.colorScheme) var colorScheme
    @State private var selection: Set<Provider> = []
    
    
    var body: some View {
        VStack{
            Button(action: {
                if providers == nil || providers.count == 0 {
                    providers = ProviderApi().getMusicProviders()
                }
                
                withAnimation {
                    isExpanded.toggle()
                }
            }, label: {
                HStack {
                    HStack(spacing: 5) {
                        Image("spotifyIconAmber").resizable().frame(width: 30 ,height: 30, alignment: .leading)
                            
                        Text("manage providers")
                            .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                            .fonzButtonText()
                            .padding(.horizontal)
                    }
                    Spacer()
                }.frame(width: UIScreen.screenWidth * .outerContainerFrameWidthSettings, height: 20)
                .padding()
                
            })
            .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
            if isExpanded {
                VStack{
                    // coasters
                    ScrollView(showsIndicators: true) {
                        LazyVGrid(columns: layout, spacing: 12) {

                            ForEach(providers, id: \.self) { item in
                                
                                Text(item.displayName)
                                        .onTapGesture {
//                                            if !self.selection.contains(item) {
                                                self.selectDeselect(item)
//                                            }
                                            
                                            print("here m8 ")
                                            
                                        }
                                    
                                        .animation(.linear(duration: 0.3))
                            }
                        }
                        .padding(.top, 5)
                        .padding(.bottom, 10)
                    }.frame(width: UIScreen.screenWidth * 0.9, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.top, 20)
                    .onAppear {
//                        if coastersConnectedToHost.products.quantity == 0 {
//                            let actuallyHasCoasters = coastersConnectedToHost.determineIfHasCoasters()
//                            if (!actuallyHasCoasters) {
//                                userAttributes.setHasConnectedCoasters(bool: false)
//                            }
//                        }
                    }
                
                }
    
            }
        }
        
    }
    
    private func selectDeselect(_ provider: Provider) {
            if selection.contains(provider) {
                selection.remove(provider)
            } else {
                selection.insert(provider)
            }
        }
}

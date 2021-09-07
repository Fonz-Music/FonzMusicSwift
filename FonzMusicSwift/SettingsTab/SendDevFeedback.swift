//
//  SendDevFeedback.swift
//  FonzMusicSwift
//
//  Created by didi on 8/31/21.
//

import SwiftUI


struct SendDevFeedback: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.openURL) var openURL
    
    
    var widthInherited : CGFloat
    
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes

    @State private var mailData = ComposeMailData(subject: "", recipients: ["contact@fonzmusic.com"], message: "", attachments: [AttachmentData(data: "Some text".data(using: .utf8)!, mimeType: "text/plain",fileName: "text.txt")])
    
    @State private var showMailView = false
    
    var body: some View {
        Button(action: {
            mailData = ComposeMailData(
                subject: "testflight user \(userAttributes.getUserDisplayName()) has issue",
                recipients: ["contact@fonzmusic.com"],
                message: "type your feedback or issue here: \n\n\n\n",
                attachments: [AttachmentData(data: "userId: \(userAttributes.getUserId())\nhasAccount: \(userAttributes.getHasAccount())\nhasSpotify: \(userAttributes.getConnectedToSpotify())\nhasCoasters: \(userAttributes.getHasConnectedCoasters())\nuserSessionId: \(userAttributes.getUserSessionId())".data(using: .utf8)!,
                mimeType: "text/plain",
                fileName: "text.txt")
            ])
            showMailView.toggle()
            
        }, label: {
            HStack {
                HStack(spacing: 5) {
                    Image(systemName: "paperplane.circle")
                        .resizable()
                        .frame(width: 30 ,height: 30, alignment: .leading)
                        .foregroundColor(.amber)
                        
                    Text("send developer feedback")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzButtonText()
                        .padding(.horizontal)                        }
                Spacer()
            }.frame(width: UIScreen.screenWidth * widthInherited, height: 20)
            .padding()
            
        })
        .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
        .sheet(isPresented: $showMailView) {
            
              MailView(data: $mailData) { result in
                print(result)
               }
            }
    }
}

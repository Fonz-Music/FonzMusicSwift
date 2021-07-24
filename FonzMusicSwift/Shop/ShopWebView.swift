//
//  ShopWebView.swift
//  FonzMusicSwift
//
//  Created by didi on 7/20/21.
//

import Foundation
import SwiftUI
import WebKit

struct ShopWebView: UIViewRepresentable {
    let url = URL(string: "https://fonzmusic.com/shop")

    func makeUIView(context: UIViewRepresentableContext<ShopWebView>) -> WKWebView {
        let webview = WKWebView()

        let request = URLRequest(url: url!, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)

        return webview
    }

    func updateUIView(_ webview: WKWebView, context: UIViewRepresentableContext<ShopWebView>) {
        let request = URLRequest(url: self.url!, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)
    }
}

//
//  SpotifyWebViewWk.swift
//  FonzMusicSwift
//
//  Created by didi on 5/1/21.
//

import Foundation
import SafariServices
import WebKit

class SpotifyWebViewWk: UIViewController, WKNavigationDelegate {

    // inits webview var
    var webView: WKWebView!
    // takes in controller for Flutter
    var controller : UIViewController? = nil
    // main function to launch webview
    func openURL(userToken: String) {
        
        // check if website exists
//        guard let url = URL(string: "https://api.fonzmusic.com/auth/spotify?token=\(userToken)") else {
//            return
//        }
        guard let url = URL(string: "https://fonzmusic.com") else {
            return
        }
        
//      this creats back button
        setToolBar()
        
        // launches webby
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    // so the webview appears
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        
    }
    //MARK:- WKNavigationDelegate Methods

        //Equivalent of shouldStartLoadWithRequest:
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            var action: WKNavigationActionPolicy?
            defer {
                decisionHandler(action ?? .allow)
            }
            guard let url = navigationAction.request.url else { return }
            print("decidePolicyFor - url: \(url)")
        }

        //Equivalent of webViewDidStartLoad:
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//            print("didStartProvisionalNavigation - webView.url: \(String(describing: webView.url?.description))")
        }

        //Equivalent of didFailLoadWithError:
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            let nserror = error as NSError
            if nserror.code != NSURLErrorCancelled {
                webView.loadHTMLString("Page Not Found", baseURL: URL(string: "https://developer.apple.com/"))
            }
        }

        //Equivalent of webViewDidFinishLoad:
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("didFinish - webView.url: \(String(describing: webView.url?.description))")
            
            // checks url, if at end of connecting, closes
            if String(describing: webView.url!.description).hasPrefix("https://api.fonzmusic.com/callback/spotify?code=") {
                    // this removes cookies and cache
                    clean()
                    // this sends msg bsck to flutter
                    DispatchQueue.main.async {
                        
                    }
                    // this dismisses the webview and returns to flutter app
                    controller?.dismiss(animated: true, completion: nil)
            }
        }
    
   // function to remove cache and cookies
    func clean() {
            HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
            print("[WebCacheCleaner] All cookies deleted")
            
            WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
                records.forEach { record in
                    WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                    print("[WebCacheCleaner] Record \(record) deleted")
                }
            }
        }
    
    
    
    // creates the back button at the bottom
    fileprivate func setToolBar() {
        let screenWidth = self.view.bounds.width
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 60))
        toolBar.isTranslucent = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false;    toolBar.items = [backButton]
        webView.addSubview(toolBar)// Constraints
        toolBar.bottomAnchor.constraint(equalTo: webView.bottomAnchor, constant: 0).isActive = true
        toolBar.leadingAnchor.constraint(equalTo: webView.leadingAnchor, constant: 0).isActive = true
        toolBar.trailingAnchor.constraint(equalTo: webView.trailingAnchor, constant: 0).isActive = true
      }
    // action for back button, dismissed webview
    @objc private func goBack() {
        controller?.dismiss(animated: true, completion: nil)
      }
}

//
//  File.swift
//  
//
//  Created by Dylan Elliott on 18/12/2023.
//

import SwiftUI
import WebKit

#if canImport(UIKit)
public struct WebView: UIViewRepresentable {
    class NavigationDelegate: NSObject, WKNavigationDelegate {

            /// Handle a failed navigation.
            func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
                print("ERROR:", error)
            }

            /// Handle a successful navigation (a response was received).
            func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
                print("RESPONSE:", navigationResponse)

                decisionHandler(.allow) // allow everything
            }
        }
    
    // 1
    let navigationDelegate: NavigationDelegate
    let url: URL

    public init(url: URL) {
        self.navigationDelegate = NavigationDelegate()
        self.url = url
    }
    
    // 2
    public func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        webview.navigationDelegate = navigationDelegate
        return webview
    }
    
    // 3
    public func updateUIView(_ webView: WKWebView, context: Context) {

        let request = URLRequest(url: url)
        webView.load(request)
    }
}
#endif

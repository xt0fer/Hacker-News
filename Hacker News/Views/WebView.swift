//
//  WebView.swift
//  News
//
//  Created by Alexandre Fabri on 2021/09/25.
//

import SwiftUI
import WebKit

/// Custom WKWebView controller to load story article
struct WebView: UIViewRepresentable {
    
    // Flag to keep track of the ProgresView
    @Binding var finished: Bool
    // The story url
    let urlString: String?
    
    let webview = WKWebView()

    
    func makeUIView(context: Context) -> WKWebView  {
        webview.allowsBackForwardNavigationGestures = true
        return webview
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let urlString = urlString, let url = URL(string: urlString) {
            // Delegation to track when page finish loading
            webView.navigationDelegate = context.coordinator
            // Load page
            webView.load(URLRequest(url: url))
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func goBack(){
        webview.goBack()
    }

    func goForward(){
        webview.goForward()
    }

    
    // Delegation
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        // If we need to handle request errors, here is the place for that.
        // For now we assume the page is done loading.
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            self.parent.finished = true
        }
        
        // The page finished loading
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.parent.finished = true
        }
        
        init(_ parent: WebView) {
            self.parent = parent
        }
    }
    
}

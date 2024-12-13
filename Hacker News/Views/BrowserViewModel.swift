//
//  BrowserViewModel.swift
//  Hacker News
//
//  Created by kristofer on 12/13/24.
//

import SwiftUI
import Foundation
import WebKit

class BrowserViewModel: NSObject, ObservableObject, WKNavigationDelegate {
    weak var webView: WKWebView? {
        didSet {
            webView?.navigationDelegate = self
        }
    }

    @Published var urlString = "https://news.ycombinator.com"
    @Published var canGoBack = true
    @Published var canGoForward = false

    func loadURLString() {
        if let url = URL(string: urlString) {
            webView?.load(URLRequest(url: url))
        }
    }

    func goBack() {
        webView?.goBack()
    }

    func goForward() {
        webView?.goForward()
    }

    func reload() {
        webView?.reload()
    }
}

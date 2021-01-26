//
//  WebView.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 26.01.2021.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero)
        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            //webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
            webView.loadHTMLString(HTMLString.htmlString, baseURL: url)
        } else {
            print("unable to load template")
        }
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}


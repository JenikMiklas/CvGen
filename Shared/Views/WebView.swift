//
//  WebView.swift
//  CvGen
//
//  Created by Jan Miklas on 26.01.2021.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero)
       
        webView.loadHTMLString(HTMLString.htmlString, baseURL: HTMLString.urlResources)
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

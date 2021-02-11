//
//  WebView.swift
//  CvGen
//
//  Created by Jan Miklas on 26.01.2021.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    let html: String
    @Binding var pdfData: Data
    
    func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero)
        webView.navigationDelegate = context.coordinator
       
        webView.loadHTMLString(html, baseURL: URL(string: "file://"))
        
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    class Coordinator : NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ uiWebView: WebView) {
                self.parent = uiWebView
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Page loaded
            self.parent.pdfData = webView.exportAsPdfFromWebView()
            
        }
    }
}

extension WKWebView {
    
    func exportAsPdfFromWebView() -> Data {
            let pdfData = createPdfFile(printFormatter: self.viewPrintFormatter())
            return pdfData as Data
        }
        
        func createPdfFile(printFormatter: UIViewPrintFormatter) -> NSMutableData {
            let A4PageWidth: CGFloat = 595.2
            let A4PageHeight: CGFloat = 841.8
            let pageFrame = CGRect(x: 0.0, y: 0.0, width: A4PageWidth, height: A4PageHeight)
            //let originalBounds = self.bounds
            //self.bounds = CGRect(x: originalBounds.origin.x, y: bounds.origin.y, width: self.bounds.size.width, height: self.scrollView.contentSize.height)
            //let pdfPageFrame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.scrollView.contentSize.height)
            //let pdfPageFrame = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)
            let printPageRenderer = UIPrintPageRenderer()
            printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
            printPageRenderer.setValue(NSValue(cgRect: pageFrame), forKey: "paperRect")
            printPageRenderer.setValue(NSValue(cgRect: pageFrame.insetBy(dx: 0.0, dy: 10.0)), forKey: "printableRect")
            //printPageRenderer.setValue(NSValue(cgRect: UIScreen.main.bounds), forKey: "paperRect")
            //printPageRenderer.setValue(NSValue(cgRect: pdfPageFrame), forKey: "printableRect")
           // self.bounds = originalBounds
            return printPageRenderer.generatePdfData()
        }
}

extension UIPrintPageRenderer {
    func generatePdfData() -> NSMutableData {
        let pdfData = NSMutableData()
        //DispatchQueue.main.async {
            UIGraphicsBeginPDFContextToData(pdfData, self.paperRect, nil)
            self.prepare(forDrawingPages: NSMakeRange(0, self.numberOfPages))
            let printRect = UIGraphicsGetPDFContextBounds()
            for pdfPage in 0..<self.numberOfPages {
                UIGraphicsBeginPDFPage()
                self.drawPage(at: pdfPage, in: printRect)
            }
            UIGraphicsEndPDFContext();
        //}
            return pdfData
        }
}

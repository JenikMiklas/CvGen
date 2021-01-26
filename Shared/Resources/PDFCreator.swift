//
//  PDFCreator.swift
//  PDFTest (iOS)
//
//  Created by Jan Miklas on 14.01.2021.
//

import Foundation
import SwiftUI
import PDFKit

class PDFCreator: NSObject {
    
    func exportHTMLContentToPDF() -> NSData {
        let printPageRenderer = CustomPrintPageRenderer()
        
         
        let printFormatter = UIMarkupTextPrintFormatter(markupText: HTMLString.htmlString)
        printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
        
        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPageRenderer)
        return pdfData ?? NSData()
        }
    
    func drawPDFUsingPrintPageRenderer(printPageRenderer: CustomPrintPageRenderer) -> NSData! {
        let data = NSMutableData()
         
        UIGraphicsBeginPDFContextToData(data, CGRect(x: 0, y: 0, width: printPageRenderer.A4PageWidth, height: printPageRenderer.A4PageHeight), nil)
         
        UIGraphicsBeginPDFPage()
         
        printPageRenderer.drawPage(at: 0, in: UIGraphicsGetPDFContextBounds())
         
        UIGraphicsEndPDFContext()
        
        return data
    }
    
}


class CustomPrintPageRenderer: UIPrintPageRenderer {
 
    let A4PageWidth: CGFloat = 595.2
 
    let A4PageHeight: CGFloat = 841.8
 
    override init() {
        
        super.init()
        
        let pageFrame = CGRect(x: 0.0, y: 0.0, width: A4PageWidth, height: A4PageHeight)
         
            // Set the page frame.
        self.setValue(NSValue(cgRect: pageFrame), forKey: "paperRect")
         
            // Set the horizontal and vertical insets (that's optional).
        self.setValue(NSValue(cgRect: pageFrame.insetBy(dx: 10.0, dy: 10.0)), forKey: "printableRect")
    }
}

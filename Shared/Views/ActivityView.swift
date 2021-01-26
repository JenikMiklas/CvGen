//
//  ActivityView.swift
//  CvGen
//
//  Created by Jan Miklas on 26.01.2021.
//

import SwiftUI
import PDFKit

struct ActivityView: UIViewControllerRepresentable {
    
    let pdfDoc: PDFDocument
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let items: [Any] = [pdfDoc.page(at: 0)!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return ac
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

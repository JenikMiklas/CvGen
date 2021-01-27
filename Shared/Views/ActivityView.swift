//
//  ActivityView.swift
//  CvGen
//
//  Created by Jan Miklas on 26.01.2021.
//

import SwiftUI
import PDFKit

struct ActivityView: UIViewControllerRepresentable {
    
    @Binding var pdfData: Data
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let items: [Any] = [pdfData]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return ac
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

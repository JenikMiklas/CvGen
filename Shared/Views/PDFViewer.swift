//
//  PDFViewer.swift
//  CvGen
//
//  Created by Jan Miklas on 26.01.2021.
//

import SwiftUI
import PDFKit
import WebKit

struct PDFViewer: View {
    
    @Binding var pdfData: Data
    
    var body: some View {
        ShowPDFView(data: pdfData)
            .navigationBarTitle("Print", displayMode: .inline)
    }
}

struct PDFViewer_Previews: PreviewProvider {
    static var previews: some View {
        PDFViewer(pdfData: .constant(Data()))
    }
}

struct ShowPDFView: UIViewRepresentable {
   
    let data: Data
    
    func makeUIView(context: Context) -> some UIView {
        let pdfView = PDFView(frame: .zero)
        pdfView.document = PDFDocument(data: data)
        pdfView.autoScales = true
        //pdfView.currentPage?.rotation = 90
        return pdfView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

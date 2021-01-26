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
    
    @State private var showSheet = false
    let data: Data
    
    var body: some View {
        ShowPDFView(data: data)
            .navigationBarTitle("Print", displayMode: .inline)
            .toolbar(content: {
                Button(action: { showSheet.toggle() }, label: {
                    Image(systemName: "square.and.arrow.up")
                })
            })
            .sheet(isPresented: $showSheet, content: {
                ActivityView(pdfDoc: PDFDocument(data: data)!)
            })
    }
}

struct PDFViewer_Previews: PreviewProvider {
    static var previews: some View {
        PDFViewer(data: Data())
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

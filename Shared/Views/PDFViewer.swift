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
    
    let pdfData: Data
    @State private var showSheet = false
    
    var body: some View {
        ShowPDFView(data: pdfData)
            .navigationBarTitle("Print", displayMode: .inline)
            .toolbar(content: {
                Button(action: { showSheet.toggle() }, label: {
                    Image(systemName: "printer")
                })
            })
            .sheet(isPresented: $showSheet, content: {
                ActivityView(pdfData: pdfData)
            })
    }
}

struct PDFViewer_Previews: PreviewProvider {
    static var previews: some View {
        PDFViewer(pdfData: Data())
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

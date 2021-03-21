//
//  PDFViewer.swift
//  CvGenUI
//
//  Created by Jan Miklas on 17.03.2021.
//

import SwiftUI
import PDFKit

struct PDFViewer: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let fileName:String
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("šablony")
            }
            .padding(.leading, 15)
            .padding([.top, .bottom])
            .foregroundColor(.primary)
            ShowPDFView(name: fileName)
                .navigationBarHidden(true)
                .onAppear {
                    print(presentationMode)
            }
        }
    }
}

struct PDFViewer_Previews: PreviewProvider {
    static var previews: some View {
        PDFViewer(fileName: "template1")
    }
}

struct ShowPDFView: UIViewRepresentable {
   
    let name: String
    
    func makeUIView(context: Context) -> some UIView {
        
        let url = Bundle.main.url(forResource: name, withExtension: "pdf")
        
        let pdfView = PDFView(frame: .zero)
        pdfView.document = PDFDocument(url: url!)
        pdfView.autoScales = true
        //pdfView.currentPage?.rotation = 90
        return pdfView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

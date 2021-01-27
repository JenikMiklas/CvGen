//
//  Home.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 26.01.2021.
//

import SwiftUI

struct Home: View {
    
    let pdfCreator = PDFCreator()
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            WebView()
                .navigationBarTitle("CvGen")
                .toolbar(content: {
                    HStack {
                        Button(action: { showSheet.toggle() }, label: {
                            Text("Print directly from WebView")
                        })
                        
                        Spacer()
                        
                        NavigationLink(
                            destination: PDFViewer(data: pdfCreator.exportHTMLContentToPDF() as Data),
                            label: {
                                Image(systemName: "printer")
                        })
                    }
                })
                .sheet(isPresented: $showSheet, content: {
                    PDFViewer(data: HTMLString.pdfData)
                })
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

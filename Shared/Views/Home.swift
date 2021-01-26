//
//  Home.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 26.01.2021.
//

import SwiftUI

struct Home: View {
    
    let pdfCreator = PDFCreator()
    
    var body: some View {
        NavigationView {
            WebView()
                .navigationBarTitle("CvGen")
                .toolbar(content: {
                    NavigationLink(
                        destination: PDFViewer(data: pdfCreator.exportHTMLContentToPDF() as Data),
                        label: {
                            Image(systemName: "printer")
                        })
                })
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

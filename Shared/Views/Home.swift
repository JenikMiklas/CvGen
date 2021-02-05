//
//  Home.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 26.01.2021.
//

import SwiftUI

struct Home: View {
    
    @State private var pdfData = Data()
    @State private var showSheet = false
    
    @EnvironmentObject var cvgVM: CvGenViewModel
    
    var body: some View {
        WebView(html: cvgVM.generateHTML(), pdfData: $pdfData)
            .navigationBarTitle("Export CV")
            .toolbar(content: {
                Button(action: { showSheet.toggle() }, label: {
                    Image(systemName: "printer")
                })
            })
            .sheet(isPresented: $showSheet, content: {
                ActivityView(pdfData: $pdfData)
            })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

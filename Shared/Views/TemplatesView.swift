//
//  Home.swift
//  CvGenUI
//
//  Created by Jan Miklas on 17.03.2021.
//

import SwiftUI

struct TemplatesView: View {
    
    private let templates = ["template1", "template2"]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 18) {
                    ForEach(0..<templates.count, id: \.self) { index in
                        NavigationLink(
                            destination:
                                PDFViewer(fileName: templates[index])
                                .navigationBarTitleDisplayMode(.inline)
                        ) {
                                Image(templates[index])
                                    .resizable()
                                    .frame(width: 200)
                                    .cornerRadius(20)
                            }
                    }
                }
                .padding(.top, 8)
                .padding(.horizontal)
            }
            .navigationBarHidden(true)
            .transition(.opacity)
        }
    }
}

struct TemplatesView_Previews: PreviewProvider {
    static var previews: some View {
        TemplatesView()
    }
}

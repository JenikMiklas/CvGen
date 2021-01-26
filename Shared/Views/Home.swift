//
//  Home.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 26.01.2021.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            WebView()
                .navigationBarTitle("CvGen")
                .toolbar(content: {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
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

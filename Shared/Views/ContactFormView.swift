//
//  ContactFormView.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 02.02.2021.
//

import SwiftUI

struct ContactFormView: View {
    
    @Binding var person: Person?
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ContactFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactFormView(person: .constant(Person()))
                .navigationBarTitle("Contact", displayMode: .inline)
        }
    }
}

//
//  ContactFormView.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 02.02.2021.
//

import SwiftUI

struct ContactFormView: View {
    
    @Binding var name: String
    @Binding var street: String
    @Binding var zip: String
    @Binding var state: String
    
    var body: some View {
        Form {
            Section(header: Text("What is your name name")) {
                TextField("Name", text: $name)
            }
            Section(header: Text("Address")) {
                TextField("Street", text: $street)
                TextField("ZIP", text: $zip)
                TextField("State", text: $state)
            }
        }
        .navigationBarTitle("Contact", displayMode: .inline)
    }
}

struct ContactFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactFormView(name: .constant("Jan Mikláš"), street: .constant("Obecnice I 234"), zip: .constant("68765"), state: .constant("Strání"))
                .navigationBarTitle("Contact", displayMode: .inline)
        }
    }
}

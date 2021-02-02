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
    @Binding var profesion: String
    @Binding var phone: String
    @Binding var email: String
    @Binding var web: String
    
    var body: some View {
        Form {
            Section(header: Text("NAME")) {
                TextField("What is your name name", text: $name)
                TextField("What is your profesion", text: $profesion)
            }
            Section(header: Text("Address")) {
                TextField("Street", text: $street)
                TextField("ZIP", text: $zip)
                TextField("State", text: $state)
            }
            Section(header: Text("Contact")) {
                TextField("phone", text: $phone)
                TextField("e-mail", text: $email)
                TextField("web", text: $web)
            }
        }
        .navigationBarTitle("Contact", displayMode: .inline)
    }
}

struct ContactFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactFormView(name: .constant("Jan Mikláš"), street: .constant("Obecnice I 234"), zip: .constant("68765"), state: .constant("Strání"), profesion: .constant("Developer"), phone: .constant("773696282"), email: .constant("jenikmiklas@gmail.com"), web: .constant("github.com/JenikMiklas"))
                .navigationBarTitle("Contact", displayMode: .inline)
        }
    }
}

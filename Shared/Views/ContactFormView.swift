//
//  ContactFormView.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 02.02.2021.
//

import SwiftUI

struct ContactFormView: View {

    @EnvironmentObject var cvgVM: CvGenViewModel
    
    @State var name: String = ""
    @State var street: String = ""
    @State var zip: String = ""
    @State var state: String = ""
    @State var profession: String = ""
    @State var phone: String = ""
    @State var email: String = ""
    @State var web: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("NAME")) {
                TextField("What is your name name", text: $name)
                    .onChange(of: name) {value in
                        cvgVM.person?.name = value
                    }
                TextField("What is your profession", text: $profession)
                    .onChange(of: profession) {value in
                        cvgVM.person?.job = value
                    }
            }
            Section(header: Text("Address")) {
                TextField("Street", text: $street)
                    .onChange(of: street) {value in
                        cvgVM.person?.address?.street = value
                    }
                TextField("ZIP", text: $zip)
                    .onChange(of: zip) {value in
                        cvgVM.person?.address?.zip = value
                    }
                TextField("State", text: $state)
                    .onChange(of: state) {value in
                        cvgVM.person?.address?.state = value
                    }
            }
            Section(header: Text("Contact")) {
                TextField("phone", text: $phone)
                    .onChange(of: phone) {value in
                        cvgVM.person?.phone = value
                    }
                TextField("e-mail", text: $email)
                    .onChange(of: email) {value in
                        cvgVM.person?.email = value
                    }
                TextField("web", text: $web)
                    .onChange(of: web) {value in
                        cvgVM.person?.web = value
                    }
            }
        }
        .navigationBarTitle("Contact", displayMode: .inline)
        .onAppear {
            if cvgVM.person == nil {
                cvgVM.person = Person(context: cvgVM.moc)
                if cvgVM.person?.address == nil {
                    cvgVM.person?.address = Address(context: cvgVM.moc)
                }
            } else {
                name = cvgVM.person?.name ?? ""
                street = cvgVM.person?.address?.street ?? ""
                zip = cvgVM.person?.address?.zip ?? ""
                state = cvgVM.person?.address?.state ?? ""
                profession = cvgVM.person?.job ?? ""
                phone = cvgVM.person?.phone ?? ""
                email = cvgVM.person?.email ?? ""
                web = cvgVM.person?.web ?? ""
            }
        }
    }
}

struct ContactFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactFormView()
                .environmentObject(CvGenViewModel(moc: PersistenceController.shared.container.viewContext))
                .navigationBarTitle("Contact", displayMode: .inline)
        }
    }
}

//
//  NewPersonView.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 01.02.2021.
//

import SwiftUI

struct NewPersonView: View {
    
    @EnvironmentObject var cvgVM: CvGenViewModel
    var person: Person?
    
    var body: some View {
        
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
            ForEach(1...7, id: \.self) { index in
                let tup = getPhotoTitle(index: index)
                NavigationLink(
                    destination: destination(key: tup.0),
                    label: {
                        Badge(image: tup.0, title: tup.1)
                    })
                VerticalDivider()
            }
            .frame(maxWidth: .infinity)
            HStack(spacing: 50) {
                NavigationLink(
                    destination: ExportView(),
                    label: {
                        Badge(image: "printer", title: "Print CV")
                    })
            }.padding(.bottom, 20)
        }
        .padding(.top, 10)
        .navigationBarTitle(getTitle() , displayMode: .inline)
        .onAppear {
            if person != nil {
                cvgVM.person = person
            }
        }
    }
    
   @ViewBuilder private func destination(key: String) -> some View {
        switch key {
        case "phone.circle":
            ContactFormView()
        case "shippingbox":
            WorkFormView()
        case "studentdesk":
            SchoolView()
        case "wrench.and.screwdriver":
           SkillView()
        case "person.3":
            SocialView()
        case "gamecontroller":
           HobbyView()
        default:
            //Text("Work in progress....")
            ImageView()
        }
    }
    private func getPhotoTitle(index: Int) -> (String, String) {
        switch index {
        case 1:
            return ("photo", "profile photo")
        case 2:
            return ("phone.circle", "contact")
        case 3:
            return ("wrench.and.screwdriver", "skill")
        case 4:
            return ("person.3", "social")
        case 5:
            return ("shippingbox", "working experiences")
        case 6:
            return ("studentdesk", "education")
        default:
            return ("gamecontroller", "hobbies")
        }
    }
    
    private func getTitle() -> String {
        guard let person = person else { return "New User CV" }
        guard let name = person.name else { return "New User CV" }
        if name == "" {
            return "New User CV"
        } else {
            return name + " CV"
        }
    }
}

struct NewPersonView_Previews: PreviewProvider {
    static let vm = CvGenViewModel(moc: PersistenceController.preview.container.viewContext)
    static var previews: some View {
        NavigationView {
            NewPersonView()
        }
    }
}

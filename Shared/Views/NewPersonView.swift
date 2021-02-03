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
            ForEach(1...5, id: \.self) { index in
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
                Button(action: { cvgVM.savePerson() }, label: {
                    Badge(image: "person.crop.circle.badge.plus", title: "save")
                })
            }.padding(.bottom, 20)
        }
        .padding(.top, 10)
        .navigationBarTitle("New User CV", displayMode: .inline)
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
        default:
            Text("Work in progress....")
        }
    }
    private func getPhotoTitle(index: Int) -> (String, String) {
        switch index {
        case 1:
            return ("photo", "profile photo")
        case 2:
            return ("phone.circle", "contact")
        case 3:
            return ("shippingbox", "working experiences")
        case 4:
            return ("studentdesk", "education")
        default:
            return ("gamecontroller", "hobbies")
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

struct Badge: View {
    
    let image: String
    let title: String
    
    var body: some View {
        VStack {
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .overlay(
                    Image(systemName: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50))
            Text(title)
                .font(.title3)
        }
        .foregroundColor(.primary)
    }
}

struct VerticalDivider: View {
    var body: some View {
        Rectangle()
            .frame(width: 7, height: 50)
            .cornerRadius(8)
            .foregroundColor(.gray)
    }
}

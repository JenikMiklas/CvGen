//
//  NewPersonView.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 01.02.2021.
//

import SwiftUI

struct NewPersonView: View {
    
    @ObservedObject var cvgVM: CvGenViewModel
    
    var body: some View {
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
            Badge(image: "photo", title: "profile photo")
            VerticalDivider()
            Badge(image: "signpost.left", title: "contact")
            VerticalDivider()
            Badge(image: "shippingbox", title: "working experiences")
            VerticalDivider()
            Badge(image: "studentdesk", title: "education")
            VerticalDivider()
            Badge(image: "gamecontroller", title: "hobbies")
        }
        .padding(.top, 10)
        .navigationBarTitle("New User CV", displayMode: .inline)
        .onAppear {
            if cvgVM.person == nil {
                cvgVM.person = Person(context: cvgVM.moc)
            }
        }
    }
}

struct NewPersonView_Previews: PreviewProvider {
    static let vm = CvGenViewModel(moc: PersistenceController.preview.container.viewContext)
    static var previews: some View {
        NavigationView {
            NewPersonView(cvgVM: vm)
        }
    }
}

struct Badge: View {
    
    let image: String
    let title: String
    
    var body: some View {
        Group {
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
        }    }
}

struct VerticalDivider: View {
    var body: some View {
        Rectangle()
            .frame(width: 7, height: 50)
            .cornerRadius(8)
            .foregroundColor(.gray)
    }
}

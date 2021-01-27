//
//  TestPersonView.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 27.01.2021.
//

import SwiftUI

struct TestPersonView: View {
    
    let person: Person
    
    var body: some View {
        Form {
            Section(header: Text("Basic info")) {
                Text("about")
                Text("\(person.name!)")
                Text("\(person.address?.street ?? "USA"), "+"\(person.address?.zip ?? 0000) "+"\(person.address?.state ?? "USA")")
                Text("Job")
                Text("tel")
                Text("e-mail")
                Text("web")
            }
            Section(header: Text("Skills")) {
                Text("skill, skill")
            }
            Section(header: Text("Socials")) {
                Text("social, social")
            }
            Section(header: Text("Jobs")) {
                Text("work, work")
            }
            Section(header: Text("Education")) {
                Text("edu, edu")
            }
            Section(header: Text("Hobbies")) {
                Text("hobby, hobby")
            }
        }
    }
}

struct TestPersonView_Previews: PreviewProvider {
    static var previews: some View {
        TestPersonView(person: Person())
    }
}

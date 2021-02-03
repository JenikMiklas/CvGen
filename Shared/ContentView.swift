//
//  ContentView.swift
//  Shared
//
//  Created by Jan Miklas on 26.01.2021.
//

import SwiftUI
//import CoreData

struct ContentView: View {
    
    //@Environment(\.managedObjectContext) private var viewContext

    @EnvironmentObject var cvgVM: CvGenViewModel
    
    /*@FetchRequest(entity: Person.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)],
                  predicate: nil,
                  animation: .default) var persons: FetchedResults<Person>*/

    var body: some View {
        NavigationView {
            List {
                ForEach(cvgVM.cvPersons) { person in
                    NavigationLink(
                        destination: NewPersonView(person: person),
                        label: {
                            CardView(name: person.name ?? "", job: person.job ?? "", phone: person.phone ?? "", email: person.email ?? "")
                        })
                }
                .onDelete(perform: deletePersons)
            }
            .navigationBarTitle("CvGen")
            .toolbar {
                Button(action: { addPerson() }, label: {
                    Image(systemName: "plus")
                })
            }
        }
    }
    
    //MARK: Testting adding and deleting
    private func addPerson() {
        withAnimation {
            cvgVM.createPerson()
        }
    }

    private func deletePersons(offsets: IndexSet) {
        withAnimation {
            cvgVM.deletePerson(offsets: offsets)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static let vm = CvGenViewModel(moc: PersistenceController.preview.container.viewContext)
    static var previews: some View {
        ContentView()
            //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct CardView: View {
    
    let name: String
    let job: String
    let phone: String
    let email: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image("face")
                .resizable()
                .frame(width: 75, height: 75)
                .clipShape(Circle())
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .trailing) {
                Text(job)
                    .font(.caption)
                Text(phone)
                    .font(.caption)
                Text(email)
                    .font(.caption)
            }
            Spacer()
            VStack {
                Text(name)
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(5)
        //.background(Color.gray)
        //.cornerRadius(10)
    }
}

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
                            Text("\(person.name ?? String(""))")
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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static let vm = CvGenViewModel(moc: PersistenceController.preview.container.viewContext)
    static var previews: some View {
        ContentView()
            //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

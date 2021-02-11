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
                            CardView(name: person.name ?? "", job: person.job ?? "", phone: person.phone ?? "", email: person.email ?? "", image: getImg(img: person.img ?? ""))
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
    
    private func getImg(img: String) -> String {
        var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].relativePath
        path += "/"+img
        return path
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
    static var previews: some View {
        ContentView()
            .environmentObject(CvGenViewModel(moc: PersistenceController.shared.container.viewContext))
            //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

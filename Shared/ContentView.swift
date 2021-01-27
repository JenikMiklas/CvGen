//
//  ContentView.swift
//  Shared
//
//  Created by Jan Miklas on 26.01.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Person.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)],
                  predicate: nil,
                  animation: .default) var persons: FetchedResults<Person>

    var body: some View {
        NavigationView {
            List {
                ForEach(persons) { person in
                    TestPersonView(person: person)
                }
                .onDelete(perform: deletePersons)
            }
            .navigationBarTitle("CvGen")
            .toolbar {
                Button(action: addPerson) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }
    
    //MARK: Testting adding and deleting
    private func addPerson() {
        withAnimation {
            let newPerson = Person(context: viewContext)
            newPerson.name = "Já"
            newPerson.born = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deletePersons(offsets: IndexSet) {
        withAnimation {
            offsets.map { persons[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
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
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

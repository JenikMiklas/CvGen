//
//  CvGenViewModel.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 01.02.2021.
//

import Foundation
import CoreData

class CvGenViewModel: NSObject, ObservableObject {
    
    @Published var cvPersons: [Person] = []
    
    @Published var person: Person?
    
    private let fetchRequestController: NSFetchedResultsController<Person>
    var moc: NSManagedObjectContext
    
    init(moc: NSManagedObjectContext) {
        
        fetchRequestController = NSFetchedResultsController(fetchRequest: Person.personFetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        self.moc = moc
        super.init()
        fetchRequestController.delegate = self
        
        do {
            try fetchRequestController.performFetch()
            cvPersons = fetchRequestController.fetchedObjects ?? []
        } catch {
            print("Error: Cannot fetch Person items!!!")
        }
    }
    
    func createPerson() {
        let newPerson = Person(context: moc)
        newPerson.name = ""
        newPerson.job = "Fill in new CV" 
        newPerson.born = Date()
        savePerson()
    }
    
    func savePerson() {
        do {
            try moc.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deletePerson(offsets: IndexSet) {
        offsets.map { cvPersons[$0] }.forEach(moc.delete)
        savePerson()
    }
    
}

extension CvGenViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let fetchedPersons = controller.fetchedObjects as? [Person] else { return }
        cvPersons = fetchedPersons
    }
}

extension Person {
    static var personFetchRequest: NSFetchRequest<Person> {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        request.predicate = nil
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return request
    }
}

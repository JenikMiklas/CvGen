//
//  PersonStorage.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 20.03.2021.
//

import Foundation
import Combine
import CoreData

class PersonStorage: NSObject, ObservableObject {
    var persons = CurrentValueSubject<[Person], Never>([])
    private let fetchRequestController: NSFetchedResultsController<Person>
    
    //MARK: SINGLETON
    static let shared: PersonStorage = PersonStorage()
    
    private override init() {
        self.fetchRequestController = NSFetchedResultsController(
            fetchRequest: Person.personFetchRequest,
            managedObjectContext: PersistenceController.shared.container.viewContext,
            sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        fetchRequestController.delegate = self
        
        do {
            try fetchRequestController.performFetch()
            persons.value = fetchRequestController.fetchedObjects ?? []
        } catch {
            print("Error: Cannot fetch Person items!!!")
        }
    }
    
    //MARK: CRUD functions
    
    static func createPerson() {
        let context = PersistenceController.shared.container.viewContext
        let newPerson = Person(context: context)
        /*newPerson.name = "Kolotoč"
        newPerson.born = Date()
        newPerson.job = "Kolotočář"
        newPerson.phone = "773 696 282"
        newPerson.about = "Kolotoč z kolotočova. Rád se otáčí kolem své osy."
        newPerson.email = "kolotoc@gmail.com"
        newPerson.web = "www.kolotoc.sk"*/
        let newAddress = Address(context: context)
        /*newAddress.state = "SK"
        newAddress.street = "Bzince 55"
        newAddress.zip = "62255"*/
        newPerson.address = newAddress
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

extension PersonStorage: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let fetchedPersons = controller.fetchedObjects as? [Person] else { return }
        persons.value = fetchedPersons
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

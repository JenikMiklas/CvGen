//
//  CvGenViewModel.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 01.02.2021.
//

import Foundation
import CoreData

enum Sections {
    case education
    case job
    case hobby
    case menu
}

class CvGenViewModel: NSObject, ObservableObject {
    
    @Published var cvPersons: [Person] = []
    
    @Published var person: Person?
    @Published var selectedObject: NSManagedObject?
    
    @Published var section: Sections = .menu
    
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
        if newPerson.address == nil {
            newPerson.address = Address(context: moc)
        }
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
    
    func deleteContect(offsets: IndexSet) {
        offsets.map { person!.jobsArray[$0] }.forEach(moc.delete)
        savePerson()
    }
    
    func createContent(header: String, content: String, from: Date, to: Date) {
        switch section {
        case .job:
            let job = Jobs(context: moc)
            job.company = header
            job.position = content
            job.periodFrom = from
            job.periodTo = to
            job.person = person
            savePerson()
        case .education:
            let school = Education(context: moc)
            school.school = header
            school.course = content
            school.periodFrom = from
            school.periodTo = to
            school.person = person
        savePerson()
        default:
            savePerson()
        }
    }
    
    func updateContent(header: String, content: String, from: Date, to: Date) {
        objectWillChange.send()
        guard let job = selectedObject as? Jobs else { return }
        job.company = header
        job.position = content
        job.periodFrom = from
        job.periodTo = to
        savePerson()
        selectedObject = nil
    }
    
    func loadContent() -> (String, String, Date, Date) {
        switch section {
        case .job:
            if let job = selectedObject as? Jobs {
                return (job.company!, job.position!, job.periodFrom!, job.periodTo!)
            } else {
                return ("", "", Date(), Date())
            }
        case .education:
            if let school = selectedObject as? Education {
                return (school.school!, school.course!, school.periodFrom!, school.periodTo!)
            } else {
                return ("", "", Date(), Date())
            }
        default:
            return ("default", "default", Date(), Date())
        }
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

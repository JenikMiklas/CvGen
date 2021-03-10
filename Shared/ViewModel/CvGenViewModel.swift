//
//  CvGenViewModel.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 01.02.2021.
//

import Foundation
import CoreData
import SwiftUI

enum Sections {
    case education
    case job
    case hobby
    case menu
    case skill
    case social
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
            //print(person?.hobby)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deletePerson(offsets: IndexSet) {
        offsets.map { cvPersons[$0] }.forEach(moc.delete)
        savePerson()
    }
    
    func deleteContect(offsets: IndexSet) {
        switch section {
        case .job:
            offsets.map { person!.jobsArray[$0] }.forEach(moc.delete)
        case .education:
            offsets.map { person!.schoolArray[$0] }.forEach(moc.delete)
        case .skill:
            offsets.map { person!.skillArray[$0] }.forEach(moc.delete)
        case .hobby:
            offsets.map { person!.hobbyArray[$0] }.forEach(moc.delete)
        default:
            return
        }
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
        case .skill:
            let skill = Skill(context: moc)
            skill.name = header
            skill.score = Int16(content) ?? 10
            skill.person = person
            savePerson()
        case .hobby:
            let hobby = Hobby(context: moc)
            hobby.name = header
            hobby.person = person
            savePerson()
        case .social:
            let social = Social(context: moc)
            social.name = header
            social.link = content
            social.person = person
            savePerson()
        default:
            savePerson()
        }
    }
    
    func updateContent(header: String, content: String, from: Date, to: Date) {
        objectWillChange.send()
        switch section {
        case .job:
            guard let job = selectedObject as? Jobs else { return }
            job.company = header
            job.position = content
            job.periodFrom = from
            job.periodTo = to
        case .education:
            guard let school = selectedObject as? Education else { return }
            school.school = header
            school.course = content
            school.periodFrom = from
            school.periodTo = to
        case .skill:
            guard let skill = selectedObject as? Skill else { return }
            skill.name = header
            skill.score = Int16(content) ?? 10
        case .hobby:
            guard let hobby = selectedObject as? Hobby else { return }
            hobby.name = header
        case .social:
            guard let social = selectedObject as? Social else { return }
            social.name = header
            social.link = content
        default:
           print("default update")
        }
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
        case .skill:
            if let skill = selectedObject as? Skill {
                return (skill.name!, "\(skill.score)", Date(), Date())
            } else {
                return ("", "", Date(), Date())
            }
        case .hobby:
            if let hobby = selectedObject as? Hobby {
                return (hobby.name!, hobby.name!, Date(), Date())
            } else {
                return ("", "", Date(), Date())
            }
        case .social:
            if let social = selectedObject as? Social {
                return (social.name!, social.link!, Date(), Date())
            } else {
                return ("", "", Date(), Date())
            }
        default:
            return ("default", "default", Date(), Date())
        }
    }
    
    func getButtonTitle() -> String {
        switch section {
        case .job:
            return selectedObject != nil ? "Update job" : "Add job"
        case .education:
            return selectedObject != nil ? "Update school" : "Add school"
        case .skill:
            return selectedObject != nil ? "Update skill" : "Add skill"
        case .hobby:
            return selectedObject != nil ? "Update hobby" : "Add hobby"
        case .social:
            return selectedObject != nil ? "Update social" : "Add social"
        default:
            return ""
        }
    }
    
    func getViewTitle() -> String {
        switch section {
        case .job:
            return "Insert new Job record"
        case .education:
            return "Insert new School record"
        case .skill:
            return "Insert new Skill record"
        default:
            return ""
        }
    }
    
    private func getSocialIcon(social: String) -> String {
        switch social {
        case "Facebook":
            return "fab fa-facebook-square"
        case "Twitter":
            return "fab fa-twitter-square"
        case "YouTube":
            return "fab fa-youtube"
        case "Linkedin":
            return "fab fa-linkedin"
        default:
            return ""
        }
    }
    ///var/mobile/Containers/Data/Application/948C2544-378F-4E28-AC36-05420520CB8F/Documents/1E808087-7F27-4D13-85C7-4823C80F6F19.jpeg
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths[0])
        return paths[0]
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

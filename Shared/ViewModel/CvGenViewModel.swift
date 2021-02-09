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
    
    func generateHTML() -> String {
        var nodeHtml = ""
        var html = HTMLString.htmlString
        html = html.replacingOccurrences(of: "#NAME#", with: person?.name ?? "")
        html = html.replacingOccurrences(of: "#CARRER#", with: person?.job ?? "")
        if let street = person?.address?.street { nodeHtml = street }
        html = html.replacingOccurrences(of: "#ADDRESS#", with: nodeHtml)
        if let zip = person?.address?.zip { nodeHtml = zip }
        if let state = person?.address?.state { nodeHtml += ", " + state }
        html = html.replacingOccurrences(of: "#STATE#", with: nodeHtml)
        html = html.replacingOccurrences(of: "#TEL#", with: person?.phone ?? "")
        html = html.replacingOccurrences(of: "#E-MAIL#", with: person?.email ?? "")
        html = html.replacingOccurrences(of: "#WEB#", with: person?.web ?? "")
        html = html.replacingOccurrences(of: "#SKILL'S#", with: "DOVEDNOSTI")
        nodeHtml = ""
        if let skills = person?.skillArray {
            for skill in skills {
                nodeHtml += """
                    <li>
                    <div class="skill_name">\(skill.name ?? "")</div>
                    <div class="skill_progress">
                    <span style="width: \(String(skill.score))%;"></span>
                    </div>
                    <div class="skill_per">\(String(skill.score))%</div>
                    </li>
                    """
            }
        }
        html = html.replacingOccurrences(of: "#SKILL#", with: nodeHtml)
        html = html.replacingOccurrences(of: "#ABOUT#", with:"O MNĚ")
        html = html.replacingOccurrences(of: "#PERSONAL#", with:person?.about ?? "")
        html = html.replacingOccurrences(of: "#JOBS#", with: "Pracovní zkušenosti")
        nodeHtml = ""
        if let jobs = person?.jobsArray {
            for job in jobs {
                let calendar = Calendar.current
                let compFrom = calendar.dateComponents([.year, .month], from: job.periodFrom ?? Date())
                let compTo = calendar.dateComponents([.year, .month], from: job.periodTo ?? Date())
                nodeHtml += """
                <li>
                    <div class="date">\(compFrom.year ?? 0) - \(compTo.year ?? 0)</div>
                    <div class="info">
                        <p class="semi-bold">
                        \(job.company ?? "")
                        </p>
                        <p>
                        \(job.position ?? "")
                        </p>
                    </div>
                </li>
                """
            }
        }
        html = html.replacingOccurrences(of: "#JOB#", with: nodeHtml)
        html = html.replacingOccurrences(of: "#EDU#", with: "Vzdělání")
        nodeHtml = ""
        if let schools = person?.schoolArray {
            for school in schools {
                let calendar = Calendar.current
                let compFrom = calendar.dateComponents([.year, .month], from: school.periodFrom ?? Date())
                let compTo = calendar.dateComponents([.year, .month], from: school.periodTo ?? Date())
                nodeHtml += """
                            <li>
                                <div class="date">\(compFrom.year ?? 0) - \(compTo.year ?? 0)</div>
                                <div class="info">
                                     <p class="semi-bold">\(school.school ?? "")</p>
                                  <p>\(school.course ?? "")</p>
                                </div>
                            </li>
                """
            }
        }
        html = html.replacingOccurrences(of: "#EDUS#", with: nodeHtml)
        html = html.replacingOccurrences(of: "#HOBBY#", with: "Záliby")
        nodeHtml = ""
        if let hobbies = person?.hobbyArray {
            for hobby in hobbies {
                nodeHtml += "<p>\(hobby.name ?? "")</p>"
            }
        }
        html = html.replacingOccurrences(of: "#HOBBIES#", with: nodeHtml)
        return html
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

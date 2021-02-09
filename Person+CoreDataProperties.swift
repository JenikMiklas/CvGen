//
//  Person+CoreDataProperties.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 08.02.2021.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var about: String?
    @NSManaged public var born: Date?
    @NSManaged public var email: String?
    @NSManaged public var job: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var web: String?
    @NSManaged public var img: String?
    @NSManaged public var address: Address?
    @NSManaged public var hobby: NSSet?
    @NSManaged public var school: NSSet?
    @NSManaged public var skill: NSSet?
    @NSManaged public var work: NSSet?
    
    public var jobsArray: [Jobs] {
        let set = work as? Set<Jobs> ?? []
        return set.sorted {
            $0.periodTo! > $1.periodTo!
        }
    }
    
    public var schoolArray: [Education] {
        let set = school as? Set<Education> ?? []
        return set.sorted {
            $0.periodTo! > $1.periodTo!
        }
    }
    
    public var skillArray: [Skill] {
        let set = skill as? Set<Skill> ?? []
        return set.sorted {
            $0.name! < $1.name!
        }
    }
    
    public var hobbyArray: [Hobby] {
        let set = hobby as? Set<Hobby> ?? []
        return set.sorted {
            $0.name! < $1.name!
        }
    }

}

// MARK: Generated accessors for hobby
extension Person {

    @objc(addHobbyObject:)
    @NSManaged public func addToHobby(_ value: Hobby)

    @objc(removeHobbyObject:)
    @NSManaged public func removeFromHobby(_ value: Hobby)

    @objc(addHobby:)
    @NSManaged public func addToHobby(_ values: NSSet)

    @objc(removeHobby:)
    @NSManaged public func removeFromHobby(_ values: NSSet)

}

// MARK: Generated accessors for school
extension Person {

    @objc(addSchoolObject:)
    @NSManaged public func addToSchool(_ value: Education)

    @objc(removeSchoolObject:)
    @NSManaged public func removeFromSchool(_ value: Education)

    @objc(addSchool:)
    @NSManaged public func addToSchool(_ values: NSSet)

    @objc(removeSchool:)
    @NSManaged public func removeFromSchool(_ values: NSSet)

}

// MARK: Generated accessors for skill
extension Person {

    @objc(addSkillObject:)
    @NSManaged public func addToSkill(_ value: Skill)

    @objc(removeSkillObject:)
    @NSManaged public func removeFromSkill(_ value: Skill)

    @objc(addSkill:)
    @NSManaged public func addToSkill(_ values: NSSet)

    @objc(removeSkill:)
    @NSManaged public func removeFromSkill(_ values: NSSet)

}

// MARK: Generated accessors for work
extension Person {

    @objc(addWorkObject:)
    @NSManaged public func addToWork(_ value: Jobs)

    @objc(removeWorkObject:)
    @NSManaged public func removeFromWork(_ value: Jobs)

    @objc(addWork:)
    @NSManaged public func addToWork(_ values: NSSet)

    @objc(removeWork:)
    @NSManaged public func removeFromWork(_ values: NSSet)

}

extension Person : Identifiable {

}

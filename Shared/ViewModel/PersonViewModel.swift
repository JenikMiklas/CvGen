//
//  PersonViewModel.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 20.03.2021.
//

import Foundation
import Combine

enum Sections {
    case education
    case job
    case hobby
    case menu
    case skill
    case social
    case templates
}

class PersonViewModel: ObservableObject {
    @Published var persons = [Person]()
    @Published var menuSection: Sections = .menu
    
    private var cancellable: AnyCancellable?
    
    init(personPublisher: AnyPublisher<[Person], Never> = PersonStorage.shared.persons.eraseToAnyPublisher()) {
        cancellable = personPublisher.sink { persons in
            self.persons = persons
        }
    }
    
    func newPerson() {
        PersonStorage.createPerson()
    }
    
    func getDocumentsDirectory(name: String) -> String {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths[0].absoluteString+name)
        return paths[0].absoluteString+name
    }
}

//
//  PersonViewModel.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 20.03.2021.
//

import Foundation
import Combine

class PersonViewModel: ObservableObject {
    @Published var persons = [Person]()
    
    private var cancellable: AnyCancellable?
    
    init(personPublisher: AnyPublisher<[Person], Never> = PersonStorage.shared.persons.eraseToAnyPublisher()) {
        cancellable = personPublisher.sink { persons in
            self.persons = persons
            print(self.persons)
            print(self.getDocumentsDirectory(name: "kolo"))
        }
    }
    
    func newPerson() {
        PersonStorage.createPerson()
    }
    
    func getDocumentsDirectory(name: String) -> String {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths[0])
        return paths[0].absoluteString+name
    }
}

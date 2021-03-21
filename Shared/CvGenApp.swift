//
//  CvGenApp.swift
//  Shared
//
//  Created by Jan Miklas on 26.01.2021.
//

import SwiftUI

@main
struct CvGenApp: App {
    /*
    let persistenceController = PersistenceController.shared
    @StateObject var cvgVM: CvGenViewModel// = CvGenViewModel(moc: PersistenceController.shared.container.viewContext)

    init() {
        let viewContext = persistenceController.container.viewContext
        let viewModel = CvGenViewModel(moc: viewContext)
        _cvgVM = StateObject(wrappedValue: viewModel)
    }
    */
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

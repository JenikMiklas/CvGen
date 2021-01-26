//
//  CvGenApp.swift
//  Shared
//
//  Created by Jan Miklas on 26.01.2021.
//

import SwiftUI

@main
struct CvGenApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            /*ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)*/
            Home()
        }
    }
}

//
//  sound_picturesApp.swift
//  sound pictures
//
//  Created by Will Hodges on 12/1/21.
//

import SwiftUI

@main
struct sound_picturesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

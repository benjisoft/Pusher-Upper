//
//  Push_UpperApp.swift
//  Shared
//
//  Created by Benji Lewis on 12/05/2021.
//

import SwiftUI

@main
struct Push_UpperApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

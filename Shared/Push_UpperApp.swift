//
//  Push_UpperApp.swift
//  Shared
//
//  Created by Benji Lewis on 12/05/2021.
//

import SwiftUI
import UserNotifications

@main
struct Push_UpperApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext).frame(minWidth: 500, idealWidth: 900, maxWidth: .infinity, minHeight: 280, idealHeight: 500, maxHeight: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
    
}

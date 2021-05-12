//
//  ContentView.swift
//  Shared
//
//  Created by Benji Lewis on 12/05/2021.
//

import SwiftUI
import CoreData
import UserNotifications

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var text1Shown: Bool = false
    @State var text2Shown: Bool = false

    var body: some View {
        VStack {
            Text("Thank you for using the Push Upper. ")
            Text("You will get a notification in one hour to do your excersises.").opacity(text1Shown ? 1 : 0)
            Text("This app will not function without notification permission. Please go to settings and enable notifications.").opacity(text2Shown ? 1 : 0)
            
            Button("Turn on Notifications") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("Notifications Accepted!")
                        let content = UNMutableNotificationContent()
                        content.title = "Do your excersise!"
                        content.subtitle = "Do it now!"
                        content.sound = UNNotificationSound.default

                        // show this notification five seconds from now
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3600, repeats: true)

                        // choose a random identifier
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                        // add our notification request
                        UNUserNotificationCenter.current().add(request)
                        print("Notification Scheduled")
                        text1Shown = true
                    } else if let error = error {
                        text2Shown = true
                        print(error.localizedDescription)
                    }
                }
            }
        }.padding()
    }
    
    }



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

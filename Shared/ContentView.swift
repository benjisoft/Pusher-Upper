//
//  ContentView.swift
//  Shared
//
//  Created by Benji Lewis on 12/05/2021.
//

import SwiftUI
import CoreData
import UserNotifications

extension Color {
    static let bg = Color("BgColour")
    static let accented = Color("AccentColor")
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var text1Shown: Bool = true
    @State var text2Shown: Bool = false
    @State var showingSuccess: Bool = false
    @State var showingError: Bool = false

    var body: some View {
        Color.bg.ignoresSafeArea().overlay(
            VStack {
                Text("Thank you for using the Push Upper. ").padding()
                Text("You will get a notification in one hour to do your excersises.").opacity(text1Shown ? 1 : 0).multilineTextAlignment(.center)
                Text("This app will not function without notification permission. Please go to settings and enable notifications.").opacity(text2Shown ? 1 : 0).multilineTextAlignment(.center)
                
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
                            showingSuccess = true
                        } else if let error = error {
                            text2Shown = true
                            print(error.localizedDescription)
                        }
                    }
                }.alert(isPresented: $showingError) {
                    Alert(title: Text("Congrats!"), message: Text("You'll get notifications every hour to do more excersises. If you push the button again, you will get more but they'll all be at the same time so maybe don't do that."), dismissButton: .default(Text("Damn it Benji!")))
                }.padding().background(Color.accented).foregroundColor(.bg).cornerRadius(15)
                
                Button("Turn off Notifications") {
                    showingError = true
                }.alert(isPresented: $showingError) {
                    Alert(title: Text("Oops, sorry!"), message: Text("I haven't built this bit yet, better do some more excersises."), dismissButton: .default(Text("Damn it Benji!")))
                }.padding().background(Color.accented).foregroundColor(.bg).cornerRadius(15)
            }.padding()
        )
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

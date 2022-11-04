//
//  SettingScreen.swift
//  Todo
//
//  Created by Anubhav Rawat on 09/10/22.
//

import SwiftUI
import UserNotifications

struct SettingScreen: View {
    var body: some View {
        ZStack{
            Color("Background").ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    Button {
                        UNUserNotificationCenter.current().requestAuthorization(options:[.sound, .alert, .badge]) { success, error in
                            if let error = error{
                                print(error.localizedDescription)
                            }else{
                                print("good")
                                let content = UNMutableNotificationContent()
                                content.title = "notification"
                                content.subtitle = "first notification"
                                content.sound = UNNotificationSound.default
                                
                                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                                
                                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                                UNUserNotificationCenter.current().add(request)
                            }
                        }
                        
                        
                    } label: {
                        Text("schedule notifications")
                    }

                }
            }
            
        }
    }
}

struct SettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingScreen()
    }
}

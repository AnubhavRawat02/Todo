//
//  HomeScreen.swift
//  Todo
//
//  Created by Anubhav Rawat on 09/10/22.
//

import SwiftUI

struct HomeScreen: View {
    @State var dates:Date = Date()
    
    var body: some View {
        ZStack{
//            Color("Background").ignoresSafeArea()
            TabView{
                TodayScreen().tabItem {
                    Image(systemName: "list.bullet")
                    Text("Today")
                }

                UpcomingScreen().tabItem {
                    Image(systemName: "list.star")
                    Text("Upcoming")
                }

                ArchivedScreen().tabItem {
                    Image(systemName: "list.bullet.clipboard")
                    Text("Archived")
                }

                SettingScreen().tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

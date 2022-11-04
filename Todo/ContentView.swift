//
//  ContentView.swift
//  Todo
//
//  Created by Anubhav Rawat on 09/10/22.
//

import SwiftUI

struct ContentView: View {
    @State var currentScreen: String = "home"
    var body: some View {
        ZStack{
            Color("Background").ignoresSafeArea()
            VStack {
                if currentScreen == "home"{
                    HomeScreen()
                }else{
                    Text("ghakjghaekg")
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

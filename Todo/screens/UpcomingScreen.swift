//
//  UpcomingScreen.swift
//  Todo
//
//  Created by Anubhav Rawat on 09/10/22.
//

import SwiftUI

struct UpcomingScreen: View {
    
    @FetchRequest(sortDescriptors: []) var ptasks: FetchedResults<PTasks>
    
    var upcomingtasks: [FetchedResults<PTasks>.Element]{
        return ptasks.filter { task in
            return task.deadline!.formatted(.dateTime.day().month().year()) > Date().formatted(.dateTime.day().month().year())
        }
    }
    
    var body: some View {
        ZStack{
            Color("Background").ignoresSafeArea()
            VStack{
                Text("Upcoming Events")
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        if upcomingtasks.count == 0{
                            Text("NO UPCOMING TASKS")
                                .fontWeight(.bold)
                                .font(.system(size: 15))
                                .padding(.top)
                                .foregroundColor(.gray)
                        }else{
                            ForEach(upcomingtasks, id: \.self){task in
                                ItemCard(projecttask: task)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct UpcomingScreen_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingScreen()
    }
}

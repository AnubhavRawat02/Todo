//
//  ArchivedProjects.swift
//  Todo
//
//  Created by Anubhav Rawat on 15/10/22.
//

import SwiftUI

struct ArchivedProjects: View {
    
    @ObservedObject var project: FetchedResults<Projects>.Element
    
    var body: some View {
        ZStack{
            Color.gray
            NavigationLink{
                ProjectScreen(project: project)
            }label: {
                HStack{
                    Text(project.title!)
                    Image(systemName: "checkmark.circle")
                    Text("\(project.completed)")
                    Image(systemName: "circle")
                    Text("\(project.totalTasks - project.completed)")
                }
            }
            
        }.frame(width: 360, height: 80)
    }
}

//struct ArchivedProjects_Previews: PreviewProvider {
//    static var previews: some View {
//        ArchivedProjects()
//    }
//}

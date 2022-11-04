//
//  ProjectScreen.swift
//  Todo
//
//  Created by Anubhav Rawat on 10/10/22.
//

import SwiftUI

struct ProjectScreen: View {
    
    @State var addnewtask: Bool = false
    @State var selectedTask: UUID = UUID()
    @ObservedObject var project: FetchedResults<Projects>.Element
    @Environment(\.managedObjectContext) var viewContext
    
    func addtask(title: String, desc: String, priority: Int, deadline: Date){
        
        let task = PTasks(context: viewContext)
        task.id = UUID()
        task.title = title
        task.desc = desc
        task.priority = Int32(priority)
        task.isDone = false
        task.dateCreated = Date()
        task.deadline = deadline
        let set: Set<SubTask> = []
        task.subtask = set
        task.project = project
        
        project.tasks?.insert(task)
        project.totalTasks = project.totalTasks + 1
        
        do{
            try viewContext.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("Background").ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        if project.tasks?.count == 0{
                            Text("no task added yet")
                        }
                        else{
                            ForEach(project.taskslist, id: \.self){task in
                                ProjectItemCard(projecttask: task)
                            }
                        }
                    }
                }
                .navigationTitle(project.title!)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    Button {
                        addnewtask = true
                    } label: {
                        Text("addnew")
                    }
                    
                    Button {
                        project.archived = !project.archived
                        do{
                            try viewContext.save()
                        }catch{
                            print(error.localizedDescription)
                        }
                    } label: {
                        Text(project.archived ? "unarchive": "archive")
                    }


                }
                .sheet(isPresented: $addnewtask) {
                    NewtaskSheet(addtask: addtask)
                }
            }
        }
    }
}

struct NewtaskSheet: View{
    
//    title description priority deadline
    @State var title: String = ""
    @State var desc: String = ""
    @State var priority: Int = 5
    @State var deadline: Date = Date()
    
    var addtask: (String, String, Int, Date)->()
    @Environment(\.dismiss) var dismiss
    var body: some View{
        VStack{
            
            TextField("title", text: $title)
            TextField("description", text: $desc)
            Picker("priority", selection: $priority) {
                Text("1").tag(1)
                Text("2").tag(2)
                Text("3").tag(3)
                Text("4").tag(4)
                Text("5").tag(5)
            }
            DatePicker("deadline", selection: $deadline)
            
            Button {
                addtask(title, desc, priority, deadline)
                DispatchQueue.main.async {
                    dismiss()
                }
            } label: {
                Text("add task")
            }
        }
    }
}

//struct ProjectScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectScreen()
//    }
//}

//
//  TodayScreen.swift
//  Todo
//
//  Created by Anubhav Rawat on 09/10/22.
//

import SwiftUI

struct TodayScreen: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: []) var tsks: FetchedResults<PTasks>
    @FetchRequest(sortDescriptors: []) var allprojects: FetchedResults<Projects>
    
    var projects: [FetchedResults<Projects>.Element]{
        return allprojects.filter { p in
            return !p.archived
        }
    }
//    @FetchRequest(sortDescriptors: []) var projects: FetchedResults<Projects>
    
    var todaytasks: [FetchedResults<PTasks>.Element]{
        return tsks.filter { tsk in
            return tsk.deadline?.formatted(.dateTime.year().month().day()) == Date().formatted(.dateTime.year().month().day())
        }
    }
    
    @State private var newList: Bool = false
    func addtask(title: String, desc: String, date: Date){
        let project = Projects(context: viewContext)
        project.id = UUID()
        project.title = title
        project.desc = desc
        project.deadline = date
        project.dateCreated = Date()
        project.totalTasks = 0
        project.completed = 0
        project.archived = false
        let set : Set<PTasks> = []
        project.tasks = set
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
                VStack(spacing:30){
                    VStack(alignment:.leading){
                        Text("PROJECTS")
                            .fontWeight(.bold)
                            .font(.system(size: 15))
                            .padding(.leading, 30)
                            .padding(.top)
                            .foregroundColor(.gray)
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                if projects.count == 0{
                                    Text("no projects created yet")
                                        .padding(.leading, 30)
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                }else{
                                    ForEach(projects, id: \.self){project in
                                        NavigationLink {
                                            ProjectScreen(project: project)
                                        } label: {
                                            ProjectCard(project: project).foregroundColor(.white)
                                        }
                                    }
                                }
                            }
                        }
                    }//project cards
                    
                    VStack{
                        Text("TODAY'S TODO ITEMS")
                            .fontWeight(.bold)
                            .font(.system(size: 15))
                            .padding(.top)
                            .foregroundColor(.gray)
                        ScrollView(.vertical, showsIndicators: false){
                            VStack{
                                if todaytasks.count == 0{
                                    Text("no items for today")
                                }else{
                                    ForEach(todaytasks, id: \.self){task in
                                        ItemCard(projecttask: task)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.all, 10)
                .navigationTitle(Text("Anubhav's Todo"))
//                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    
                    Button {
                        for p in projects{
                            viewContext.delete(p)
                        }
                        
                        do{
                            try viewContext.save()
                        }catch{
                            print(error.localizedDescription)
                        }
                        
                    } label: {
                        Image(systemName: "trash")
                            .font(.system(size: 23))
                    }
                    Button {
                        newList = !newList
                        print("pressed")
                        print(newList)
                    } label: {
                        PlusIcon()
                    }
                    
                    


                }
                .sheet(isPresented: $newList, content: {
                    SheetView(newList: $newList, addtask: addtask)
                })
            }
            
        }
    }
}

struct SheetView: View{
    
    @Binding var newList: Bool
    @Environment(\.dismiss) var dismiss
    @State var title: String = ""
    @State var desc: String = ""
    @State var deadline: Date = Date()
    var addtask: (String, String, Date) -> ()
    
    var body: some View{
        VStack{
            TextField("title", text: $title)
            TextField("description", text: $desc)
            DatePicker("pick the deadline", selection: $deadline)
            Button {
                addtask(title, desc, deadline)
                DispatchQueue.main.async {
                    newList = !newList
                    dismiss()
                }
            } label: {
                Text("add project")
            }

        }
    }
}



struct TodayScreen_Previews: PreviewProvider {
    static var previews: some View {
        TodayScreen()
    }
}

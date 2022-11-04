//
//  ProjectItemCard.swift
//  Todo
//
//  Created by Anubhav Rawat on 10/10/22.
//

import SwiftUI

struct ProjectItemCard: View {
    
    @State private var showDetails: Bool = false
    @State private var showSubtasks: Bool = false
    
    @ObservedObject var projecttask: FetchedResults<PTasks>.Element
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        ZStack{
            Color.white
            VStack(spacing:20){
                HStack(){
                    
                    Image(systemName: projecttask.isDone ? "checkmark.circle" : "circle")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundStyle(.pink)
                        .onTapGesture {
                            projecttask.isDone = !projecttask.isDone
                            if projecttask.isDone{
                                projecttask.project?.completed = projecttask.project!.completed + 1
                            }else{
                                projecttask.project?.completed = projecttask.project!.completed - 1
                            }
                            do{
                                try viewContext.save()
                            }catch{
                                print(error.localizedDescription)
                            }
                        }
                    Text("\(projecttask.title ?? "akh")").font(.system(size: 18))
                    Spacer()
                    Image(systemName: showDetails ? "chevron.up" : "chevron.down")
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.2)) {
                                showDetails = !showDetails
                            }
                        }
                }
                .foregroundColor(.black)
                if showDetails{
                    Divider().overlay(.black)
                    Text("desc: \(projecttask.desc!)").foregroundColor(.black)
                    Text("deadline: \(projecttask.deadline!.formatted(.dateTime.day().month().year()))").foregroundColor(.black)
//                    Button {
//                        showSubtasks = true
//                    } label: {
//                        Text("show subtasks 3").foregroundColor(.white)
//                    }
                }

            }
            .padding(.all, 15)
        }
        
        .frame(width: 360, height: showDetails ? 170 : 60)
        .cornerRadius(20)
        
    }
}

//struct ProjectItemCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectItemCard().previewLayout(.sizeThatFits).padding()
//    }
//}

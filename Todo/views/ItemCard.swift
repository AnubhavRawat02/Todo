//
//  ItemCard.swift
//  Todo
//
//  Created by Anubhav Rawat on 09/10/22.
//

import SwiftUI

struct ItemCard: View {
    
    @ObservedObject var projecttask: FetchedResults<PTasks>.Element
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        ZStack{
            Color.white
            HStack(spacing: 20){
                Image(systemName: projecttask.isDone ? "checkmark.circle" : "circle")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
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
                    .foregroundColor(.pink)
                VStack(alignment:.leading){
                    Text(projecttask.title ?? "AHrhar")
                        .font(.system(size: 18))
                    Text("project: \((projecttask.project?.title) ?? "shrjjj")")
                        .font(.system(size: 15))
                        .fontWeight(.light)
                }
                Spacer()
            }
            .foregroundColor(.black)
            .padding(.all, 5)
        }.frame(width: 350, height: 70)
            .cornerRadius(20)
    }
}

//struct ItemCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemCard().previewLayout(.sizeThatFits)
//            .padding()
//    }
//}

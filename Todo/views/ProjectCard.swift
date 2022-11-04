//
//  ProjectCard.swift
//  Todo
//
//  Created by Anubhav Rawat on 09/10/22.
//

import SwiftUI

struct ProjectCard: View {
    
    @ObservedObject var project: FetchedResults<Projects>.Element
    var body: some View {
        ZStack{
            Color.white
            VStack{
                HStack{
                    Text((project.deadline?.formatted(.dateTime.day().month().year())) ?? "aghae")
                    Spacer()
                    Text("\(project.totalTasks)")
                }.padding(.bottom, 5)
                Text(project.title ?? "abce")
                if project.totalTasks == 0{
                    ProgressView("", value: 1, total: 1)
                        .tint(.pink)
                        .progressViewStyle(DarkBlueShadowProgressViewStyle())
                }else{
                    ProgressView("", value: Float(project.completed), total: Float(project.totalTasks))
                        .tint(.pink)
                        .progressViewStyle(DarkBlueShadowProgressViewStyle())
                }
                
            }
            .foregroundColor(.black)
            .padding()
        }.frame(width: 200, height: 150)
            .cornerRadius(20)
    }
}

struct DarkBlueShadowProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .shadow(color: Color.gray, radius: 3, x: 3, y: 3)
    }
}

//struct ProjectCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectCard().previewLayout(.sizeThatFits).padding()
//    }
//}

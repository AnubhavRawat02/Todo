//
//  ArchivedScreen.swift
//  Todo
//
//  Created by Anubhav Rawat on 09/10/22.
//

import SwiftUI

struct ArchivedScreen: View {
    
    @FetchRequest(sortDescriptors: []) var projects: FetchedResults<Projects>
    
    var archivedProjects: [FetchedResults<Projects>.Element]{
        return projects.filter { p in
            return p.archived
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("Background").ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        if archivedProjects.count == 0{
                            Text("NO ARCHIVED PROJECTS")
                                .fontWeight(.bold)
                                .font(.system(size: 15))
                                .padding(.top)
                                .foregroundColor(.gray)
                        }else{
                            ForEach(archivedProjects, id: \.self){p in
                                ArchivedProjects(project: p)
                            }
                        }
                        
                    }
                }
                .navigationTitle("Archived Projects")
                .navigationBarTitleDisplayMode(.inline)
            }
            
        }
    }
}

struct ArchivedScreen_Previews: PreviewProvider {
    static var previews: some View {
        ArchivedScreen()
    }
}

//
//  PlusIcon.swift
//  Todo
//
//  Created by Anubhav Rawat on 23/10/22.
//

import SwiftUI

struct PlusIcon: View {
    var body: some View {
        ZStack{
            Color.blue
            Image(systemName: "plus")
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundColor(.white)
        }.frame(width: 35, height: 35)
            .cornerRadius(20)
            .shadow(radius: 5)
    }
}

struct PlusIcon_Previews: PreviewProvider {
    static var previews: some View {
        PlusIcon()
    }
}

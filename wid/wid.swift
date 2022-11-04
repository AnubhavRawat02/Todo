//
//  wid.swift
//  wid
//
//  Created by Anubhav Rawat on 16/10/22.
//

import WidgetKit
import SwiftUI
import CoreData

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), count: 3, tasks: ["Task one", "Task two"], completed: 3, remaining: 2)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), count: 3, tasks: ["Task one", "Task two"], completed: 3, remaining: 2)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let moc = DataController.shared.container.viewContext
        let request = NSFetchRequest<PTasks>(entityName: "PTasks")
        let alltasks = try! moc.fetch(request)
        
        var todaytasks: [PTasks]{
            alltasks.filter { task in
                return task.deadline?.formatted(.dateTime.year().month().day()) == Date().formatted(.dateTime.year().month().day())
            }
        }
        
        var tasksString: [String]{
            var tskstr: [String] = []
            for tsk in todaytasks{
                if(tskstr.count == 2){
                    break
                }
                tskstr.append(tsk.title!)
            }
            return tskstr
        }
        
        var remaining: Int{
            var rem = 0
            for task in todaytasks{
                if !task.isDone{
                    rem = rem + 1
                }
            }
            return rem
        }
        
        var completed: Int{
            var com = 0
            for task in todaytasks{
                if task.isDone{
                    com = com + 1
                }
            }
            return com
        }
        
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//
//        }
        let entry = SimpleEntry(date: Date(), count: 3, tasks: tasksString, completed: completed, remaining: remaining)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let count:Int
    let tasks: [String]
    let completed: Int
    let remaining: Int
}

struct widEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        if widgetFamily == .systemSmall{
            smallWid(entry: entry)
        }else{
            mediumWid(entry: entry)
        }
    }
}


struct smallWid: View{
    var entry: Provider.Entry
    
    var progress: CGFloat{
        
        let ret = CGFloat(entry.completed/(entry.completed + entry.remaining))
        
        return ret
    }
    
    func temp(str: String) -> String{
        let start = str.index(str.startIndex, offsetBy: 8)
        let end = str.index(str.endIndex, offsetBy: -10)
        let range = start..<end

        let mySubstring = str[range]
        
        return String(mySubstring)
    }
    var body: some View{
        ZStack{
            Color.white
            VStack(alignment: .leading){
                HStack{
                    VStack{
                        Text("\(entry.date.formatted(.dateTime.weekday()).uppercased())")
                            .font(.system(size: 12))
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        Text("\(temp(str: entry.date.ISO8601Format()))")
                            .font(.system(size: 25))
                    }
                    Spacer()
                    CircularProgressView(fract: CGFloat(entry.completed) / CGFloat(entry.completed + entry.remaining), big: false)
                    Spacer()
                    
                }
                
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("\(entry.remaining + entry.completed) today")
                }
                HStack{
                    Image(systemName: "checkmark")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    Text("\(entry.completed) completed")
                }
                HStack{
                    Image(systemName: "list.clipboard.fill")
                        .foregroundColor(.red)
                    Text("\(entry.remaining) remaining")
                }
                
                Spacer()
            }
            .padding()
        }
        
    }
}

struct mediumWid: View{
    var entry: Provider.Entry
    
    func temp(str: String) -> String{
        let start = str.index(str.startIndex, offsetBy: 8)
        let end = str.index(str.endIndex, offsetBy: -10)
        let range = start..<end

        let mySubstring = str[range]
        
        return String(mySubstring)
    }
    
    var body: some View{
        ZStack{
            Color.white
            
            VStack{
                HStack(spacing: 20){
                    VStack{
                        Text("\(entry.date.formatted(.dateTime.weekday()).uppercased())")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        Text("\(temp(str: entry.date.ISO8601Format()))")
                            .font(.system(size: 38))
                    }.padding(.leading, 20)
                    
                    CircularProgressView(fract: CGFloat(entry.completed) / CGFloat(entry.completed + entry.remaining), big: true)
//                    Spacer()
                    
                    VStack(alignment: .leading){
                        Text("Today")
                            .foregroundColor(.gray)
                            .fontWeight(.bold)
                            .font(.system(size: 15))
                        if entry.tasks.count == 0{
                            Text("no tasks for today")
                            
                        }
                        if entry.tasks.count >= 1{
                            Text("\(entry.tasks[0])")
                                .font(.system(size: 15))
                        }
                        if entry.tasks.count >= 2{
                            Text("\(entry.tasks[1])")
                                .font(.system(size: 15))
                        }
                        if entry.remaining > 2{
                            Text("\(entry.remaining - 2) more...")
                                .font(.system(size: 13))
                                .foregroundColor(Color.gray.opacity(0.7))
                        }
                        
                    }
                    .padding(.trailing, 30)
                }
                .padding(.horizontal, 20)
                Spacer()
                HStack{
                    HStack(spacing: 3){
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(entry.remaining + entry.completed) today")
                            .font(.system(size: 15))
                    }
                    HStack(spacing: 3){
                        Image(systemName: "checkmark")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                        Text("\(entry.completed) completed")
                            .font(.system(size: 15))
                    }
                    HStack(spacing: 3){
                        Image(systemName: "list.clipboard.fill")
                            .foregroundColor(.red)
                        Text("\(entry.remaining) remaining")
                            .font(.system(size: 15))
                    }
                }
            }
            .padding(.vertical, 30)
        }
    }
}

struct largeWid: View{
    var body: some View{
        ZStack{
            
        }
    }
}

@main
struct wid: Widget {
    let kind: String = "wid"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            widEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct CircularProgressView: View {
    
    var fract: CGFloat
    var big: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.pink.opacity(0.3),
                    lineWidth: big ? 8 : 4
                )
            Circle()
                .trim(from: 0, to: fract)
                .stroke(
                    Color.pink,
                    lineWidth: big ? 8 : 4
                ).rotationEffect(.degrees(-90))
            Text("\(Int(fract * 100)) %")
                .font(.system(size: big ? 16 : 10))
        }
        .frame(width: big ? 50 : 35, height: big ? 50 : 35)
    }
}

struct wid_Previews: PreviewProvider {
    static var previews: some View {
        widEntryView(entry: SimpleEntry(date: Date(), count: 3, tasks: ["Task one", "Task two"], completed: 4, remaining: 3))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

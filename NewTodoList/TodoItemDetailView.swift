//
//  TodoItemDetailView.swift
//  NewTodoList
//
//  Created by Alphonso Sensley II on 8/1/21.
//

import SwiftUI
@available(iOS 15.0, *)
struct TodoItemDetailView: View {
    @State var todoItem: TodoItem
    @State var passedDescription = ""
    var index = Int()
    var body: some View {
        
        VStack {
            VStack {
                Text(todoItem.taskName)
                    .fontWeight(.heavy)
                    .font(.largeTitle)
            }
            
            TextField("Add Description Here", text: $passedDescription)
                .font(.subheadline)
                .frame(width: 200, height: 200, alignment: .leading)
            
        }
        .onAppear(perform: {
           // passedDescription = todoItem.description ?? ""
        })
        .onDisappear {
           // guard (todoItem.detailDescription != "") else {return}
            var newValue = String()
            for item in MainViewController.listsOfTasks {
                if item.taskName == todoItem.taskName {
                    
                        newValue = passedDescription
                        todoItem.detailDescription = newValue
                        MainViewController.listsOfTasks.remove(at: index)
                        MainViewController.listsOfTasks.insert(todoItem, at: index)
                }
            }
            
         //   MainViewController.listsOfTasks.append(TodoItem(taskName: "New Task", dueDate: nil, description: nil, complete: false))
            MainViewController.tableView.reloadData()
            print(MainViewController.listsOfTasks)
        }    }
}
@available(iOS 15.0, *)
struct TodoItemDetailView_Previews: PreviewProvider {
   
    static var previews: some View {
        TodoItemDetailView(todoItem: TodoItem(taskName: "Test", dueDate: nil, detailDescription: nil, complete: false))
    }
}

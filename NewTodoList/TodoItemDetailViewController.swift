//
//  TodoItemDetailViewController.swift
//  NewTodoList
//
//  Created by Alphonso Sensley II on 8/1/21.
//

import UIKit
import SwiftUI

class TodoItemDetailViewController: UIViewController {
    var todoItem : TodoItem?
    var index = Int()
    var taskName = ""
    let dueDateLabel = UILabel()
    var descriptionText = ""
    let completedImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwiftUIView()
    }
    
    fileprivate func setupSwiftUIView() {
        //The UIHostingViewController acts as a container for the specified SwiftUI View
        guard let item = todoItem else {return}
        if #available(iOS 15.0, *) {
            let SwiftUIViewHostingController = UIHostingController(rootView:TodoItemDetailView(todoItem: item, index: index))
            view.addSubview(SwiftUIViewHostingController.view)
            SwiftUIViewHostingController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                SwiftUIViewHostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
                SwiftUIViewHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                SwiftUIViewHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                SwiftUIViewHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            SwiftUIViewHostingController.didMove(toParent: self)
        } else {
            // Fallback on earlier versions
        }
    }
}

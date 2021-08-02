//
//  ViewController.swift
//  NewTodoList
//
//  Created by Alphonso Sensley II on 8/1/21.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellId = "myCell"
    static let tableView = UITableView()
    let textField = UITextField()
    static var listsOfTasks:[TodoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        MainViewController.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        MainViewController.tableView.reloadData()
    }
    
    func setupTableView() {
        view.addSubview(MainViewController.tableView)
        MainViewController.tableView.delegate = self
        MainViewController.tableView.dataSource = self
        MainViewController.tableView.rowHeight = 70
        MainViewController.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                                        MainViewController.tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
                                        MainViewController.tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                        MainViewController.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 0),
                                        MainViewController.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),MainViewController.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
    
    func setupTextField() {
        view.addSubview(textField)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Write New Todo Item Here"
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 20
        NSLayoutConstraint.activate([
            textField.bottomAnchor.constraint(equalTo: MainViewController.tableView.topAnchor, constant: -10),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 250),
            textField.heightAnchor.constraint(equalToConstant: 50)
        
        ])
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MainViewController.listsOfTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        cell.textLabel?.text = MainViewController.listsOfTasks[indexPath.row].taskName
        cell.detailTextLabel?.text = MainViewController.listsOfTasks[indexPath.row].detailDescription
        cell.accessoryType = MainViewController.listsOfTasks[indexPath.row].complete ? .checkmark : .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailViewController = TodoItemDetailViewController()
        detailViewController.todoItem = MainViewController.listsOfTasks[indexPath.row]
        detailViewController.index = indexPath.row
        //navigationController?.pushViewController(detailViewController, animated: true)
        navigationController?.present(detailViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            MainViewController.listsOfTasks.remove(at: indexPath.row)
               tableView.deleteRows(at: [indexPath], with: .fade)
           } else if editingStyle == .insert {
               // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
           }
    }
}

extension MainViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let task = textField.text else {return}
        guard !task.isEmpty else {print("No Text Was entered"); return}
        let newTodoItem = TodoItem(taskName: task, dueDate: nil, detailDescription: nil, complete: false)
        MainViewController.listsOfTasks.append(newTodoItem)
        textField.text = ""
        MainViewController.tableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
   
}


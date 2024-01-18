//
//  ViewController.swift
//  ToDoWithUT
//
//  Created by Eugene on 11/01/2024.
//

import UIKit

class TaskListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var dataProvider: DataProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let taskManager = TaskManager()
        dataProvider.taskManager = taskManager
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: String(describing: NewTaskVC.self)) as? NewTaskVC {
            viewController.taskManager = self.dataProvider.taskManager
            present(viewController, animated: true, completion: nil)
        }
    }
    
}


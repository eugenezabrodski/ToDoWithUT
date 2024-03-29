//
//  DataProvider.swift
//  ToDoWithUT
//
//  Created by Eugene on 12/01/2024.
//

import UIKit

enum Section: Int, CaseIterable {
    case todo
    case done
}

class DataProvider: NSObject {
    
    var taskManager: TaskManager?
    
}

extension DataProvider: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = Section(rawValue: section) else { fatalError() }
        guard let taskManager = taskManager else { return 0 }
        
        switch section {
        case .todo:
            return taskManager.tasksCount
        case .done:
            return taskManager.doneTaskCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self), for: indexPath) as! TaskCell
        
        guard let section = Section(rawValue: indexPath.section),
              let taskManager = taskManager else { fatalError() }
        let task: Task
        switch section {
        case .todo:
            task = taskManager.task(at: indexPath.row)
        case .done:
            task = taskManager.doneTask(at: indexPath.row)
        }
        
        cell.configure(withTask: task)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        guard let section = Section(rawValue: indexPath.section) else { fatalError()}
        switch section {
        case .done:
            return "Not done"
        case .todo:
            return "Done"
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let section = Section(rawValue: indexPath.section),
              let taskManager = taskManager else { fatalError() }
        
        switch section {
        case .todo:
            taskManager.checkTask(at: indexPath.row)
        case .done:
            taskManager.uncheckTask(at: indexPath.row)
        }
        
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
        
    }
    
}


//
//  TaskCell.swift
//  ToDoWithUT
//
//  Created by Eugene on 12/01/2024.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    func configure(withTask task: Task, done: Bool = false) {
        
        if done {
            let attributedString = NSAttributedString(string: task.title, attributes: [NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue])
            titleLabel.attributedText = attributedString
            dateLabel = nil
            locationLabel = nil
        } else {
            self.titleLabel.text = task.title
            self.locationLabel.text = task.location?.name
            
            let df = DateFormatter()
            df.dateFormat = "dd.MM.yy"
            let dateString = df.string(from: task.date)
            dateLabel.text = dateString
        }
    }

}

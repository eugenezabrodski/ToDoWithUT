//
//  NewTaskVC.swift
//  ToDoWithUT
//
//  Created by Eugene on 15/01/2024.
//

import UIKit
import CoreLocation

class NewTaskVC: UIViewController {
    
    var taskManager: TaskManager!
    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
    var geocoder = CLGeocoder()

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var adressTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func save() {
        let titleString = titleTextField.text
        let locationString = locationTextField.text
        let date = dateFormatter.date(from: dateTextField.text!)
        let descriptionString = descriptionTextField.text
        let adressString = adressTextField.text
        
        geocoder.geocodeAddressString(adressString!) { [unowned self] (placemarks, error) in
            let placemark = placemarks?.first
            let coordinate = placemark?.location?.coordinate
            let location = Location(name: locationString!, coordinate: coordinate)
            let task = Task(title: titleString!, description: descriptionString, location: location, date: date)
            self.taskManager.add(task: task)
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
        }
    }
    

}

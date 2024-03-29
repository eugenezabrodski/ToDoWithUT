//
//  DetailVC.swift
//  ToDoWithUT
//
//  Created by Eugene on 15/01/2024.
//

import UIKit
import MapKit

class DetailVC: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    
    var task: Task!
    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.titleLabel.text = task.title
        self.descriptionLabel.text = task.description
        self.locationLabel.text = task.location?.name
        self.dateLabel.text = dateFormatter.string(from: task.date)
        
        if let coordinates = task.location?.coordinate {
            let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 100, longitudinalMeters: 100)
            mapView.region = region
        }
    }
    


}

//
//  NewTaskVCTests.swift
//  ToDoWithUTTests
//
//  Created by Eugene on 15/01/2024.
//

import XCTest
import CoreLocation
@testable import ToDoWithUT

final class NewTaskVCTests: XCTestCase {

    var sut: NewTaskVC!
    var placemark: MockCLPlacemark!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: NewTaskVC.self)) as? NewTaskVC
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHasTitleTF() {
        XCTAssertTrue(sut.titleTextField.isDescendant(of: sut.view))
    }
    
    func testHasLocationTF() {
        XCTAssertTrue(sut.locationTextField.isDescendant(of: sut.view))
    }
    
    func testHasDateTf() {
        XCTAssertTrue(sut.dateTextField.isDescendant(of: sut.view))
    }
    
    func testHasAdressTf() {
        XCTAssertTrue(sut.adressTextField.isDescendant(of: sut.view))
    }
    
    func testHasdescriptionTf() {
        XCTAssertTrue(sut.descriptionTextField.isDescendant(of: sut.view))
    }
    
    func testSaveToUseGeocoder() {
        
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        let date = df.date(from: "01.01.19")
        
        sut.titleTextField.text = "Foo"
        sut.locationTextField.text = "Bar"
        sut.dateTextField.text = "01.01.19"
        sut.adressTextField.text = "Minsk"
        sut.descriptionTextField.text = "Baz"
        sut.taskManager = TaskManager()
        let mockGeocoder = MockCLGeoCoder()
        sut.geocoder = mockGeocoder
        
        sut.save()
        
        let locationes = CLLocationCoordinate2D(latitude: 53.896196, longitude: 27.5503093)
        let location = Location(name: "Bar", coordinate: locationes)
        let generatedTask = Task(title: "Foo",description: "Baz", location: location, date: date)
        placemark.mockCoordinate = locationes
        mockGeocoder.completionHandler?([placemark], nil)
        let task = sut.taskManager.task(at: 0)
        
        XCTAssertEqual(task, generatedTask)
    }
    
    func testGeocoderCorrectCoordinates() {
        let geocoderAnswer = expectation(description: "Geocoder answer")
        let adressString = "Минск"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(adressString) { placemarks, error in
            let placemark = placemarks?.first
            let location = placemark?.location
            guard let latitude = location?.coordinate.latitude,
                  let longitude = location?.coordinate.longitude
            else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(latitude, 53.896196)
            XCTAssertEqual(longitude, 27.5503093)
            geocoderAnswer.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }

}

extension NewTaskVCTests {
    
    class MockCLGeoCoder: CLGeocoder {
        var completionHandler: CLGeocodeCompletionHandler?
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }
    
    class MockCLPlacemark: CLPlacemark {
        
        var mockCoordinate: CLLocationCoordinate2D!
        override var location: CLLocation? {
            return CLLocation(latitude: mockCoordinate.latitude, longitude: mockCoordinate.longitude)
        }
    }
}

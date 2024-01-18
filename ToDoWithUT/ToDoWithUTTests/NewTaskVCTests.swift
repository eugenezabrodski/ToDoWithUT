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
    
    func testSaveDismissNewTaskVC() {
        let mockNewTaskVC = MockNewTaskViewController()
        mockNewTaskVC.titleTextField = UITextField()
        mockNewTaskVC.titleTextField.text = "Foo"
        mockNewTaskVC.descriptionTextField = UITextField()
        mockNewTaskVC.descriptionTextField.text = "Bar"
        mockNewTaskVC.locationTextField = UITextField()
        mockNewTaskVC.locationTextField.text = "Baz"
        mockNewTaskVC.adressTextField = UITextField()
        mockNewTaskVC.adressTextField.text = "Minsk"
        mockNewTaskVC.dateTextField = UITextField()
        mockNewTaskVC.dateTextField.text = "01.01.19"
        
        mockNewTaskVC.save()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(mockNewTaskVC.isDismiss)
        }
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

extension NewTaskVCTests {
    class MockNewTaskViewController: NewTaskVC {
        var isDismiss = false
        
        override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            isDismiss = true
        }
    }
}

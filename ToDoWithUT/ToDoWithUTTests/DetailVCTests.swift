//
//  DetailVCTests.swift
//  ToDoWithUTTests
//
//  Created by Eugene on 15/01/2024.
//

import XCTest
import CoreLocation
@testable import ToDoWithUT

final class DetailVCTests: XCTestCase {

    var sut: DetailVC!
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHasTitleLabel() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: String(describing: DetailVC.self)) as! DetailVC
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertTrue(sut.titleLabel.isDescendant(of: sut.view))
        
    }
    
    func testHasDescriptionLabel() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: String(describing: DetailVC.self)) as! DetailVC
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.descriptionLabel)
        XCTAssertTrue(sut.descriptionLabel.isDescendant(of: sut.view))
        
    }
    
    func testHasDateLabel() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: String(describing: DetailVC.self)) as! DetailVC
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.dateLabel)
        XCTAssertTrue(sut.dateLabel.isDescendant(of: sut.view))
        
    }
    
    func testHasLocationLabel() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: String(describing: DetailVC.self)) as! DetailVC
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.locationLabel)
        XCTAssertTrue(sut.locationLabel.isDescendant(of: sut.view))
        
    }
    
    func testHasMapView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: String(describing: DetailVC.self)) as! DetailVC
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.mapView)
        XCTAssertTrue(sut.mapView.isDescendant(of: sut.view))
    }
    
    func testSettingsTaskInTitleLabel() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: String(describing: DetailVC.self)) as! DetailVC
        sut.loadViewIfNeeded()
        let coordinates = CLLocationCoordinate2D(latitude: 2.0, longitude: 2.0)
        let location = Location(name: "Baz", coordinate: coordinates)
        let date = Date(timeIntervalSince1970: 1546300800)
        let task = Task(title: "Foo", description: "Bar", location: location, date: date)
        
        sut.task = task
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        XCTAssertEqual(sut.titleLabel.text, "Foo")
    }
    
    func testSettingsTaskInDescriptionLabel() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: String(describing: DetailVC.self)) as! DetailVC
        sut.loadViewIfNeeded()
        let coordinates = CLLocationCoordinate2D(latitude: 2.0, longitude: 2.0)
        let location = Location(name: "Baz", coordinate: coordinates)
        let date = Date(timeIntervalSince1970: 1546300800)
        let task = Task(title: "Foo", description: "Bar", location: location, date: date)
        
        sut.task = task
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        XCTAssertEqual(sut.descriptionLabel.text, "Bar")
    }
    
    func testSettingsTaskInLocationLabel() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: String(describing: DetailVC.self)) as! DetailVC
        sut.loadViewIfNeeded()
        let coordinates = CLLocationCoordinate2D(latitude: 2.0, longitude: 2.0)
        let location = Location(name: "Baz", coordinate: coordinates)
        let date = Date(timeIntervalSince1970: 1546300800)
        let task = Task(title: "Foo", description: "Bar", location: location, date: date)
        
        sut.task = task
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        XCTAssertEqual(sut.locationLabel.text, "Baz")
    }
    
    func testSettingsTaskInDateLabel() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: String(describing: DetailVC.self)) as! DetailVC
        sut.loadViewIfNeeded()
        let coordinates = CLLocationCoordinate2D(latitude: 2.0, longitude: 2.0)
        let location = Location(name: "Baz", coordinate: coordinates)
        let date = Date(timeIntervalSince1970: 1546300800)
        let task = Task(title: "Foo", description: "Bar", location: location, date: date)
        
        sut.task = task
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        XCTAssertEqual(sut.dateLabel.text, "01.01.19")
    }
    
    func testSettingsTaskInMapView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: String(describing: DetailVC.self)) as! DetailVC
        sut.loadViewIfNeeded()
        let coordinates = CLLocationCoordinate2D(latitude: 2.0, longitude: 2.0)
        let location = Location(name: "Baz", coordinate: coordinates)
        let date = Date(timeIntervalSince1970: 1546300800)
        let task = Task(title: "Foo", description: "Bar", location: location, date: date)
        
        sut.task = task
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude, 2.0, accuracy: 0.001)
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude, 2.0, accuracy: 0.001)
    }

}

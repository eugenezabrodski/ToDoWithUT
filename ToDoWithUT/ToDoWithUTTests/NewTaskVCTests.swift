//
//  NewTaskVCTests.swift
//  ToDoWithUTTests
//
//  Created by Eugene on 15/01/2024.
//

import XCTest
@testable import ToDoWithUT

final class NewTaskVCTests: XCTestCase {

    var sut: NewTaskVC!
    
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

}

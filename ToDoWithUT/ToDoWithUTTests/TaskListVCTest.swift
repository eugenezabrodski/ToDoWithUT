//
//  TaskListVCTest.swift
//  ToDoWithUTTests
//
//  Created by Eugene on 11/01/2024.
//

import XCTest
@testable import ToDoWithUT

final class TaskListVCTest: XCTestCase {

    var sut: TaskListVC!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListVC.self))
        sut = vc as? TaskListVC
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTableViewNotNil() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func testDataProviderIsNotNill() {
        XCTAssertNotNil(sut.dataProvider)
    }
    
    func testWhenTableViewDelegateIsSet() {
        XCTAssertTrue(sut.tableView.delegate is DataProvider)
    }
    
    func testWhenTableViewDataSourceIsSet() {
        XCTAssertTrue(sut.tableView.dataSource is DataProvider)
    }
    
    func testWhenDelegateEqualsDataSource() {
        XCTAssertEqual(
            sut.tableView.delegate as? DataProvider,
            sut.tableView.dataSource as? DataProvider
        )
    }
    
    

}

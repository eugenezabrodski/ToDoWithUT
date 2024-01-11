//
//  TaskListVCTest.swift
//  ToDoWithUTTests
//
//  Created by Eugene on 11/01/2024.
//

import XCTest
@testable import ToDoWithUT

final class TaskListVCTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTableViewNotNil() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListVC.self))
        let sut = vc as! TaskListVC
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.tableView)
    }

}

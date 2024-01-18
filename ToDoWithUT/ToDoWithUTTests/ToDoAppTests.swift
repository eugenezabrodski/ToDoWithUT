//
//  ToDoAppTests.swift
//  ToDoWithUTTests
//
//  Created by Eugene on 18/01/2024.
//

import XCTest
@testable import ToDoWithUT

final class ToDoAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitialViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let rootViewController = navigationController.viewControllers.first as! TaskListVC
        XCTAssertTrue(rootViewController is TaskListVC)
    }
    
    

}

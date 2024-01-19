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
    
    func testTaskListVCHasAddBarButtomWithSelfTarget() {
        let target = sut.navigationItem.rightBarButtonItem?.target
        XCTAssertEqual(target as? TaskListVC, sut)
    }
    
    func testAddNewTaskPresentNewTaskVC() {
        XCTAssertNil(sut.presentedViewController)
        
        guard let newTaskButton = sut.navigationItem.rightBarButtonItem,
              let action = newTaskButton.action
        else {
            XCTFail()
            return
        }
        UIApplication.shared.keyWindow?.rootViewController = sut
        sut.performSelector(onMainThread: action, with: newTaskButton, waitUntilDone: true)
        XCTAssertNotNil(sut.presentedViewController)
        XCTAssertTrue(sut.presentedViewController is NewTaskVC)
        
        let newTaskViewController = sut.presentedViewController as! NewTaskVC
        XCTAssertNotNil(newTaskViewController.titleTextField)
    }
    
    func testSharesSameTaskManager() {
        XCTAssertNil(sut.presentedViewController)
        
        guard let newTaskButton = sut.navigationItem.rightBarButtonItem,
              let action = newTaskButton.action
        else {
            XCTFail()
            return
        }
        UIApplication.shared.keyWindow?.rootViewController = sut
        sut.performSelector(onMainThread: action, with: newTaskButton, waitUntilDone: true)
        XCTAssertNotNil(sut.presentedViewController)
        XCTAssertTrue(sut.presentedViewController is NewTaskVC)
        
        let newTaskViewController = sut.presentedViewController as! NewTaskVC
        XCTAssertNotNil(sut.dataProvider.taskManager)
        XCTAssertTrue(newTaskViewController.taskManager === sut.dataProvider.taskManager)
    }
    
    func testWhenViewAppearTableViewReloadData() {
        let mockTableView = MockTableView()
        sut.tableView = mockTableView
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        XCTAssertTrue((sut.tableView as! MockTableView).isReload)
    }
    
    func testTappingCellNotification() {
        let task = Task(title: "Foo")
        sut.dataProvider.taskManager?.add(task: task)
        //expectation(forNotification: <#T##NSNotification.Name#>, object: <#T##Any?#>, handler: <#T##XCTNSNotificationExpectation.Handler?##XCTNSNotificationExpectation.Handler?##(Notification) -> Bool#>)
    }

}

extension TaskListVCTest {
    class MockTableView: UITableView {
        var isReload = false
        override func reloadData() {
            isReload = true
        }
    }
}

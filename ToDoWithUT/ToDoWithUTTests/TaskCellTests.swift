//
//  TaskCellTests.swift
//  ToDoWithUTTests
//
//  Created by Eugene on 15/01/2024.
//

import XCTest
@testable import ToDoWithUT

final class TaskCellTests: XCTestCase {

    var cell: TaskCell!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListVC.self)) as! TaskListVC
        controller.loadViewIfNeeded()
        
        let tableView = controller.tableView
        let dataSource = fakeDataSource()
        tableView?.dataSource = dataSource
        
        cell = tableView?.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self), for: IndexPath(row: 0, section: 0)) as? TaskCell
        
    }

    override func tearDownWithError() throws {

    }
    
    func testCellHasTitleLabel() {
        XCTAssertNotNil(cell.titleLabel)
    }
    
    func testCellHasTitleInContentView() {
        XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
    }
    
    func testCellHasDateLabel() {
        XCTAssertNotNil(cell.dateLabel)
    }
    
    func testCellHasDateLabelInContentView() {
        XCTAssertTrue(cell.dateLabel.isDescendant(of: cell.contentView))
    }
    
    func testCellHasLocationLabel() {
        XCTAssertNotNil(cell.locationLabel)
    }
    
    func testCellHasLocationLabelInContentView() {
        XCTAssertTrue(cell.locationLabel.isDescendant(of: cell.contentView))
    }
    
    func testConfigureSetsTitle() {
        let task = Task(title: "Foo")
        cell.configure(withTask: task)
        
        XCTAssertEqual(cell.titleLabel.text, task.title)
    }
    
    func testConfigureSetDate() {
        let task = Task(title: "Foo")
        cell.configure(withTask: task)
        
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        let date = task.date
        let dateString = df.string(from: date)
        
        XCTAssertEqual(cell.dateLabel.text, dateString)
    }
    
    func testConfigureSetLocation() {
        let location = Location(name: "Foo")
        let task = Task(title: "Bar", location: location)
        
        cell.configure(withTask: task)
        
        XCTAssertEqual(cell.locationLabel.text, task.location?.name)
    }
    
    func testDoneTestStrikeThrought() {
        let task = Task(title: "Foo")
        cell.configure(withTask: task, done: true)
        
        let attributedString = NSAttributedString(string: "Foo", attributes: [NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue])
        
        XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
    }
    
    func testDoneTaskLabelEqualsNil() {
        let task = Task(title: "Foo")
        cell.configure(withTask: task, done: true)
        
        XCTAssertNil(cell.dateLabel)
    }
    
    func testLocationLabelEqualNil() {
        let task = Task(title: "Foo")
        cell.configure(withTask: task, done: true)
        
        XCTAssertNil(cell.locationLabel)
    }
}

extension TaskCellTests {
    class fakeDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
        
        
    }
}

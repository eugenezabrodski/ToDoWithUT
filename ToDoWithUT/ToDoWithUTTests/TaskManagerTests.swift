//
//  TaskManagerTests.swift
//  ToDoWithUTTests
//
//  Created by Eugene on 11/01/2024.
//

import XCTest
@testable import ToDoWithUT

final class TaskManagerTests: XCTestCase {
    
    var sut: TaskManager!

    override func setUpWithError() throws {
        sut = TaskManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testInitTaskManager() {
        XCTAssertEqual(sut.tasksCount, 0)
    }
    
    func testInitTaskManagerDone() {
        XCTAssertEqual(sut.doneTaskCount, 0)
    }
    
    func testAddTask() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        XCTAssertEqual(sut.tasksCount, 1)
    }
    
    func testTaskIndex() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        
        let returnedTask = sut.task(at: 0)
        XCTAssertEqual(task.title, returnedTask.title)
    }
    
    func testCheckAtIndex() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        
        sut.checkTask(at: 0)
        XCTAssertEqual(sut.tasksCount, 0)
        XCTAssertEqual(sut.doneTaskCount, 1)
    }
    
    func testRemoveFromArrayTask() {
        let task1 = Task(title: "Foo")
        let task2 = Task(title: "Bar")
        
        sut.add(task: task1)
        sut.add(task: task2)
        
        sut.checkTask(at: 0)
        XCTAssertEqual(sut.task(at: 0), task2)
    }
    
    func testDoneTaskArray() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        sut.checkTask(at: 0)
        let returnedTask = sut.doneTask(at: 0)
        
        XCTAssertEqual(returnedTask, task)
    }
    
    func testRemoveAll() {
        sut.add(task: Task(title: "Foo"))
        sut.add(task: Task(title: "Bar"))
        
        sut.checkTask(at: 0)
        sut.removeAll()
        
        XCTAssertTrue(sut.tasksCount == 0)
        XCTAssertTrue(sut.doneTaskCount == 0)
    }
    
    func testAddSameObject() {
        sut.add(task: Task(title: "Foo"))
        sut.add(task: Task(title: "Foo"))
        
        XCTAssertTrue(sut.tasksCount == 1)
    }

}

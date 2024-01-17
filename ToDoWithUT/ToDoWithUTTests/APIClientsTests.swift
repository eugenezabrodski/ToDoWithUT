//
//  APIClientsTests.swift
//  ToDoWithUTTests
//
//  Created by Eugene on 17/01/2024.
//

import XCTest
@testable import ToDoWithUT

final class APIClientsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoginUsesCorrectHost() {
        let mockUrlSession = MockURLSession()
        let sut = APIClient()
        sut.urlSession = mockUrlSession
        
        let completionHandler = {(token: String?, error: Error?) in }
        sut.login(withName: "name", password: "qwerty", completionHandler: completionHandler)
        
        guard let url = mockUrlSession.url else {
            XCTFail()
            return
        }
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        XCTAssertEqual(urlComponents?.host, "todoapp.com")
    }

}

extension APIClientsTests {
    class MockURLSession: URLSessionProtocol {
        var url: URL?
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            return URLSession.shared.dataTask(with: url)
        }
    }
}

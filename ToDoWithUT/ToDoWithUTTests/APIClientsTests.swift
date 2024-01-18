//
//  APIClientsTests.swift
//  ToDoWithUTTests
//
//  Created by Eugene on 17/01/2024.
//

import XCTest
@testable import ToDoWithUT

final class APIClientsTests: XCTestCase {
    
    var sut: APIClient!
    var mockURLSession: MockURLSession!

    override func setUpWithError() throws {
        mockURLSession = MockURLSession(data: nil, urlResponse: nil, responseError: nil)
        sut = APIClient()
        sut.urlSession = mockURLSession
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func userLogin() {
        let completionHandler = {(token: String?, error: Error?) in }
        sut.login(withName: "name", password: "%qwerty", completionHandler: completionHandler)
    }
    
    func testLoginUsesCorrectHost() {
        userLogin()
        XCTAssertEqual(mockURLSession.urlComponents?.host, "todoapp.com")
    }
    
    func testLoginUserCorrectPath() {
        userLogin()
        XCTAssertEqual(mockURLSession.urlComponents?.path, "/login")
    }
    
    func testLoginUsesQuery() {
        userLogin()
        
        guard let queryItems = mockURLSession.urlComponents?.queryItems else {
            XCTFail()
            return
        }
        let queryItemName = URLQueryItem(name: "name", value: "name")
        let queryItemPassword = URLQueryItem(name: "password", value: "%qwerty")
        
        XCTAssertTrue(queryItems.contains(queryItemName))
        XCTAssertTrue(queryItems.contains(queryItemPassword))
    }
    
    func testSuccesfulLoginToken() {
        let jsonDataStub = "{\"token\":\"tokenString\"}".data(using: .utf8)
        mockURLSession = MockURLSession(data: jsonDataStub, urlResponse: nil, responseError: nil)
        sut.urlSession = mockURLSession
        let tokenExpectation = expectation(description: "Token expectation")
        var catchToken: String?
        sut.login(withName: "login", password: "password") { token, _ in
            catchToken = token
            tokenExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(catchToken, "tokenString")
        }
    }
    
    func testLoginInvalidJSON() {
        mockURLSession = MockURLSession(data: Data(), urlResponse: nil, responseError: nil)
        sut.urlSession = mockURLSession
        let errorExpectation = expectation(description: "Token expectation")
        var catchError: Error?
        sut.login(withName: "login", password: "password") { token, error in
            catchError = error
            errorExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(catchError)
        }
    }
    
    func testLoginWhenDataIsNil() {
        mockURLSession = MockURLSession(data: nil, urlResponse: nil, responseError: nil)
        sut.urlSession = mockURLSession
        let errorExpectation = expectation(description: "Error expectation")
        var catchError: Error?
        sut.login(withName: "login", password: "password") { token, error in
            catchError = error
            errorExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(catchError)
        }
    }
    
}

extension APIClientsTests {
    class MockURLSession: URLSessionProtocol {
        var url: URL?
        var urlComponents: URLComponents? {
            guard let url = url else {
                return nil
            }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        private let mockDataTask: MockURLSessionDataTask
        
        init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
            mockDataTask = MockURLSessionDataTask(data: data, urlRespons: urlResponse, responseError: responseError)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            mockDataTask.completionHandler = completionHandler
            return mockDataTask
        }
    }
    
    class MockURLSessionDataTask: URLSessionDataTask {
        
        private let data: Data?
        private let urlRespons: URLResponse?
        private let responseError: Error?
        
        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler: CompletionHandler?
        
        init(data: Data?, urlRespons: URLResponse?, responseError: Error?) {
            self.data = data
            self.urlRespons = urlRespons
            self.responseError = responseError
        }
        
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler?(
                    self.data,
                    self.urlRespons,
                    self.responseError
                )
            }
        }
    }
}

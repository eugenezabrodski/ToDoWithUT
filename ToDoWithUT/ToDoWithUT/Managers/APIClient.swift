//
//  APIClient.swift
//  ToDoWithUT
//
//  Created by Eugene on 17/01/2024.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

enum NetworkError: Error {
    case emptyData
}

extension URLSession: URLSessionProtocol {}

class APIClient {
    lazy var urlSession: URLSessionProtocol = URLSession.shared
    
    func login(withName name: String, password: String, completionHandler: @escaping (String?, Error?) -> Void) {
        let allowedCharacters = CharacterSet.urlQueryAllowed
        guard let name = name.addingPercentEncoding(withAllowedCharacters: allowedCharacters),
              let password = password.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else { fatalError() }
        let query = "name=\(name)&password=\(password)"
        guard let url = URL(string: "https://todoapp.com/login?\(query)") else { fatalError() }
        urlSession.dataTask(with: url) { data, response, error in
            do {
                guard let data = data else { 
                    completionHandler(nil, NetworkError.emptyData)
                    return }
                let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String : String]
                let token = dictionary["token"]
                completionHandler(token, nil)
            } catch {
                completionHandler(nil, error)
            }
        }.resume()
        
    }
}

extension String {
    var percentEncoded: String {
        let allowedCharacters = CharacterSet(charactersIn: "!@#$%^&*()-+=[]\\}{,./?><").inverted
        guard let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else { fatalError() }
        return encodedString
    }
}

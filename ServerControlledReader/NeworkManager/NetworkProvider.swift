//
//  NetworkProvider.swift
//  ServerControlledReader
//
//  Created by certainly on 2017/9/17.
//  Copyright © 2017年 certainly. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
}


class NetworkProvider {
    private static let usingTestServer = false
    static private let host = usingTestServer ? "http://10.0.0.9:8083" : "http://104.194.77.164:8083"
    
    static func fetchMainList(update: Bool, _ success: (([JSONItem]) -> Void)?) {
        let url:String

        if update {
            url =  host + "/api/v1/posts/refresh"
        } else {
            url = host + "/api/v1/posts/all"
        }
         getPosts(requesturl: url) { (result) in
            switch result {
            case .success(let posts):
                print("cout: \(posts.count)")
                success?(posts)
            case .failure(let error):
            fatalError("error: \(error.localizedDescription)")
            }
        }
        
    }
    
    static func fetchDetailList(header: [String: String], _ success:(([JSONItem]) -> Void)?) {
        let url: String
        url = host + "/api/v1/posts/detail"
//        let header = ["cid" : cid]
        getPosts(requesturl: url, headerPara: header) { (result) in
            switch result {
            case .success(let posts):
                print("cout: \(posts.count)")
                success?(posts)
            case .failure(let error):
                fatalError("error: \(error.localizedDescription)")
            }
        }
        
        
    }
    
    private static func getPosts(requesturl: String, headerPara: [String: String]? = nil ,completion: ((Result<[JSONItem]>) -> Void)?) {

//        urlComponents.scheme = "https"
//        urlComponents.host = "jsonplaceholder.typicode.com"
//        urlComponents.path = "/posts"
//        let userIdItem = URLQueryItem(name: "userId", value: "\(userId)")
//        urlComponents.queryItems = [userIdItem]
        guard let url = URL(string: requesturl)else { fatalError("Could not create URL from components") }
        
    
       
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        for (key , val) in headerPara ?? [:] {
            request.setValue(val, forHTTPHeaderField: key)
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                guard responseError == nil else {
                    completion?(.failure(responseError!))
                    return
                }
                
                guard let jsonData = responseData else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    completion?(.failure(error))
                    return
                }
                
                // Now we have jsonData, Data representation of the JSON returned to us
                // from our URLRequest...
                
                // Create an instance of JSONDecoder to decode the JSON data to our
                // Codable struct
                let decoder = JSONDecoder()
                
                do {
                    // We would use Post.self for JSON representing a single Post
                    // object, and [Post].self for JSON representing an array of
                    // Post objects
                    
                    let posts = try decoder.decode([JSONItem].self, from: jsonData)
                    completion?(.success(posts))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    
}

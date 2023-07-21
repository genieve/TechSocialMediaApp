//
//  APIController.swift
//  techSocialMediaApp
//
//  Created by Alexis Wright on 7/19/23.
//

import Foundation

enum APIError: Error, LocalizedError {
    case networkNotReached
}

class APIController {
    
    func getAllPosts() async throws -> [Post] {
        
//        1. Create a baseURL
        let baseURL = "https://tech-social-media-app.fly.dev/posts"
        
//        2. set up the baseURL to have URL components
        var urlComponents = URLComponents(string: baseURL)
        
//        3. create query items (OR body parameters) or both...
        let urlQuery = [
            URLQueryItem(name: "userSecret", value: User.current?.secret.uuidString)]
        
//        4. adding the query items to the urlComponents variable
        urlComponents?.queryItems = urlQuery
        
//        5. Send the data to the server
        let (data, response) = try await URLSession.shared.data(from: urlComponents!.url!)
        
//        6. Checking if it's successful
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else { throw APIError.networkNotReached }
        
//        7. Making the data reusable by decoding it
        let decoder = JSONDecoder()
        let arrayOfPosts = try decoder.decode([Post].self, from: data)
        
//        8. Return decoded data
        return arrayOfPosts
    }
    
    
    func getUserProfile() async throws -> UserProfile {
        
//        1. Create a baseURL
        let baseURL = "https://tech-social-media-app.fly.dev/userProfile"
        
//        2. set up the baseURL to have URL components
        var urlComponents = URLComponents(string: baseURL)
        
//        3. create query items (OR body parameters) or both...
        let urlQuery = [
            URLQueryItem(name: "userSecret", value: User.current?.secret.uuidString),
            URLQueryItem(name: "userUUID", value: User.current?.userUUID.uuidString)]
        
//        4. adding the query items to the urlComponents variable
        urlComponents?.queryItems = urlQuery
        
//        5. Send the data to the server
        let (data, response) = try await URLSession.shared.data(from: urlComponents!.url!)
        
//        6. Checking if it's successful
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else { throw APIError.networkNotReached }
        
//        7. Making the data reusable by decoding it
        let decoder = JSONDecoder()
        let userProfile = try decoder.decode(UserProfile.self, from: data)
        
//        8. Return decoded data
        return userProfile
    }
    
    func deletePosts(postId: Int) async throws {
        let baseURL = "https://tech-social-media-app.fly.dev/post"
        
        var urlComponents = URLComponents(string: baseURL)
        
        let urlQuery = [URLQueryItem(name: "userSecret", value: User.current?.secret.uuidString),
                        URLQueryItem(name: "postid", value: String(postId))]
        urlComponents?.queryItems = urlQuery
        
        var urlRequest = URLRequest(url: urlComponents!.url!)
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "DELETE"
        
        let _ = try await URLSession.shared.data(for: urlRequest)
        
    }
    func editPost(post: Post) async throws {
        
        let baseURL = "https://tech-social-media-app.fly.dev/editPost"
        
        let urlComponents = URLComponents(string: baseURL)
        
        var urlRequest = URLRequest(url: urlComponents!.url!)
        
        let jsonEncoder = JSONEncoder()
        let bodyParameters: [String: Any] = [
            "userSecret": User.current!.secret.uuidString,
            "post": [
                "postid": post.postid,
                "title": post.title,
                "body": post.body
                ] as [String : Any]]
        
        let jsonData = try JSONSerialization.data(withJSONObject: bodyParameters, options: .prettyPrinted)
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw APIError.networkNotReached }
  
    }
    
    
    func createPost(title: String, body: String) async throws -> Post {
        //        1. Create a baseURL
        let baseURL = "https://tech-social-media-app.fly.dev/createPost"
        
        //        2. set up the baseURL to have URL components
        let urlComponents = URLComponents(string: baseURL)
        
        //        3. add components to the url request
        var urlRequest = URLRequest(url: urlComponents!.url!)
        //        4. Set up the body
        
        //        Taking something from swift and making it usable by json
        let jsonEncoder = JSONEncoder()
        let bodyParameters: CreatePostBody = CreatePostBody(userSecret: User.current!.secret.uuidString, post: ["title": title, "body": body])
        
//        Make a struct that you access and pass in instead of a dictionary up above
        
        let jsonData = try jsonEncoder.encode(bodyParameters)
        print(String(decoding: jsonData, as: UTF8.self))
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
            
            //        5. Send the data to the server
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            //        6. Checking if it's successful
        guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 else { throw APIError.networkNotReached }
            
            //        7. Making the data reusable by decoding it
        let decoder = JSONDecoder()
        let post = try decoder.decode(Post.self, from: data)
            
            //        8. Return decoded data
        return post
        
    }
    
}

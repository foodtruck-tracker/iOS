//
//  RegisterController.swift
//  FoodTruckTracker
//
//  Created by Lambda_School_Loaner_218 on 1/7/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "Delete"
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
    case noEncode
}

class RegisterController {
    
    var user: [User] = []
    var bearer: Bearer?
    let baseURL = URL(string: "https://foodtrucktrackerbw.herokuapp.com/")
    
    
    func signUp(with user: User, completion: @escaping (Error?) -> Void) {
        guard let url = baseURL else { return }
        let signUpURL = url.appendingPathComponent("api/auth/register")
        var request = URLRequest(url: signUpURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(user)
            request.httpBody = data 
        } catch {
            print("Error encoding: \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
            }
        }.resume()
    }
    
    func login(with user: User, completion: @escaping (Error?) -> Void) {
        guard let url = baseURL else { return }
        let loginURL = url.appendingPathComponent("/api/auth/login")
        var request = URLRequest(url: loginURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(user)
            request.httpBody = data
        } catch {
            print("Error logging \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                self.bearer = try decoder.decode(Bearer.self, from: data)
            } catch {
                print("Error decoding: \(error)")
                completion(error)
                return
            }
            DispatchQueue.main.async {
                completion(nil)
            }
        }.resume()
    }
    
    
}

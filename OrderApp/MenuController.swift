//
//  MenuController.swift
//  OrderApp
//
//  Created by Yuki Tsukada on 2021/01/17.
//

import Foundation
import UIKit

class MenuController {
    var order = Order() {
        didSet {
            NotificationCenter.default.post(name: MenuController.orderUpdatedNotification, object: nil)
        }
    }
    static let orderUpdatedNotification = Notification.Name("MenuController.orderUpdated")
    static let shared = MenuController()
    let baseURL = URL(string: "http://localhost:8080/")!
    
    
    
    // The code was changed from Result<[String], Error> to [String]? in the book,
    // but it causes error in the code p470
    func fetchCategories(completion: @escaping (Result<[String], Error>) -> Void) {
        let categoriesURL = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoriesURL) {
            (data, response, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let categoriesResponse = try jsonDecoder.decode(CategoriesResponse.self, from: data)
                    completion(.success(categoriesResponse.categories))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // from Result<[MenuItem], Error> to [MenuItem]?
    // the same as above
    func fetchMenuItems(forCategory categoryName: String, completion: @escaping (Result<[MenuItem], Error>) -> Void) {
        // changed from baseMenuURL to initialMenuURL
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        let task = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let menuResponse = try jsonDecoder.decode(MenuResponse.self, from: data)
                    completion(.success(menuResponse.items))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    typealias MinutesToPrepare = Int
    
    func submitOrder(forMenuIDs menuIDs: [Int], completion: @escaping (Result<MinutesToPrepare, Error>) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let data = ["menuIds": menuIDs]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let orderResponse = try jsonDecoder.decode(OrderResponse.self, from: data)
                    completion(.success(orderResponse.prepTime))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    /**
     None  of the images exists on the server.
     print("nil, \(url)") returns
        nil, http://localhost:8080/images/1.png
        nil, http://localhost:8080/images/2.png
        nil, http://localhost:8080/images/3.png
        nil, http://localhost:8080/images/4.png
        nil, http://localhost:8080/images/5.png
        nil, http://localhost:8080/images/6.png
     
            When I accessed http://localhost:8080/images/1.png,
            It returned {"error":true,"reason":"The menu item with ID 1.png does not exist."}
     */
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
               let image = UIImage(data: data) {
                print("image, \(url)")
                completion(image)
            } else {
                print("nil, \(url)")
                completion(nil)
            }
        }
        task.resume()
    }
}

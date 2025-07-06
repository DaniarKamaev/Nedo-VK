//
//  PostsWork.swift
//  test app
//
//  Created by dany on 04.07.2025.
//

import UIKit


class PostsApiWork {
    func request(completion: @escaping (Result<Data, Error>) -> Void ) {
        let urlString = "https://jsonplaceholder.typicode.com/photos"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}


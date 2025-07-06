//
//  PostsWork.swift
//  test app
//
//  Created by dany on 04.07.2025.
//

import UIKit


class PostsApiWork {
        func request() {
        let urlString = "https://jsonplaceholder.typicode.com/photos"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
                let posts = try? JSONDecoder().decode([Post].self, from: data)
                print("Received \(posts!.count) posts")
           
            if let firstPost = posts!.randomElement() {
                    print("First post ID: \(firstPost.id)")
                    print("First post title: \(firstPost.title)")
                }
        }
        task.resume()
    }
}


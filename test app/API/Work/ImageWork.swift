//
//  ImageWork.swift
//  test app
//
//  Created by dany on 04.07.2025.
//
import UIKit


class ImageApiWork {
    
    struct APIDataImage: Decodable {
        let message: String
    }
    
    func fetchRandomDogImage(completion: @escaping (String) -> Void) {
        let randomDogUrl = "https://dog.ceo/api/breeds/image/random"
        let url = URL(string: randomDogUrl)!
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion("")
                return
            }
            
            if let decodedData = try? JSONDecoder().decode(APIDataImage.self, from: data) {
                completion(decodedData.message)
            } else {
                completion("")
            }
        }
        task.resume()
    }
    
    lazy var requestImage: (String, @escaping (UIImage?) -> Void) -> Void = { url, completion in
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: url),
                  let imageData = try? Data(contentsOf: imageUrl) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    func getRandomDogImage(completion: @escaping (UIImage?) -> Void) {
        fetchRandomDogImage { [weak self] imageUrl in
            guard let self = self, !imageUrl.isEmpty else {
                completion(nil)
                return
            }
            
            self.requestImage(imageUrl, completion)
        }
    }
}

//
//  ImageWork.swift
//  test app
//
//  Created by dany on 04.07.2025.
//
import UIKit

struct ImageApiWork {
    var randomDogUrl = "https://dog.ceo/api/breeds/image/random"
    let reqest = { () -> UIImage in
        let imageUrl = URL(string: "https://images.dog.ceo/breeds/terrier-fox/n02095314_1917.jpg")
        guard let url = imageUrl, let imageData = try? Data(contentsOf: url) else {return UIImage(named: "notFound")!}
        let image = UIImage(data: imageData)
        return image!
        
    }

    
    
}



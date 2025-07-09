//
//  CastomCell.swift
//  test app
//
//  Created by dany on 06.07.2025.
//

import UIKit

class CastomCell: UITableViewCell {
    var apiPosts = PostsApiWork()
    var apiImage = ImageApiWork()
    
    private let postSmallText: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 16, weight: .semibold)
        lable.numberOfLines = 0
        lable.setContentCompressionResistancePriority(.required, for: .vertical)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let postLable: UILabel = {
        let lable = UILabel()
        lable.font = .boldSystemFont(ofSize: 20)
        lable.numberOfLines = 2
        lable.setContentCompressionResistancePriority(.required, for: .vertical)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    private let postPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI() {
            contentView.addSubview(postPhoto)
            contentView.addSubview(postLable)
            contentView.addSubview(postSmallText)
            
            NSLayoutConstraint.activate([
                postPhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                postPhoto.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                postPhoto.widthAnchor.constraint(equalToConstant: 50),
                postPhoto.heightAnchor.constraint(equalToConstant: 50),
                postPhoto.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12),
                
                postLable.leadingAnchor.constraint(equalTo: postPhoto.trailingAnchor, constant: 20),
                postLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                postLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -40),
                postLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60),
                
                postSmallText.leadingAnchor.constraint(equalTo: postPhoto.trailingAnchor, constant: 45),
                postSmallText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
                postSmallText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                postSmallText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            ])
        }
    func configurate(with modelPost: Post, with modelPhoto: ImageApiWork ) {
        postLable.text = modelPost.title
        postSmallText.text = modelPost.title
        
        
        apiImage.getRandomDogImage { [weak self] image in
            DispatchQueue.main.async {
                    self?.postPhoto.image = image ?? UIImage(named: "notFound")
            }
        }
    }
    
}

//
//  ViewController.swift
//  test app
//
//  Created by dany on 04.07.2025.
//

import UIKit

class ViewController: UIViewController {

    var apiImage = ImageApiWork()
    var apiPosts = PostsApiWork()
    let data = DataH.shared
    var myTable = UITableView()
    var myImageView = UIImageView()
    var Posts: [Post] = []
    var indificator = "cell"
    let url = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        creatadTable(myTable)
        loadData()
        //createdImageView(myImageView)
       
    }
    private func loadData() {
        apiPosts.request { [weak self] result in
            DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                let posts = try? JSONDecoder().decode([Post].self, from: data)
                print(posts?.count ?? 0)
                self?.Posts = posts!
                print(self?.Posts)
                self?.myTable.reloadData()
                let post = posts?.randomElement()
                print(post?.id ?? 0)
                print(post?.title ?? "0")
            }
        }
        }
    }
    
    
    private func createdImageView(_ imageView: UIImageView) {
        imageView.frame = CGRect(x: 0, y: 100, width: 400, height: 400)
        imageView.center.x = view.center.x
        imageView.backgroundColor = .orange
        let myQuoew = DispatchQueue.global(qos: .utility)
        myQuoew.async {
            
            self.apiImage.getRandomDogImage { image in
                if let image = image {
                    imageView.image = image
                } else {
                    print("error dounload image")
                }
            }
        }
        view.addSubview(imageView)
    }
    func creatadTable(_ table: UITableView) {
        table.frame = view.frame
        table.register(UITableViewCell.self, forCellReuseIdentifier: self.indificator)
        table.delegate = self
        table.dataSource = self
        view.addSubview(table)
    }
}
//MARK: - Extension
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Posts.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: self.indificator, for: indexPath)
        let post = Posts[indexPath.row]
        cell.textLabel?.text = post.title
        return cell
    }
    
    
}



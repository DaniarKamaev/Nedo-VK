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
    var myTable = UITableView()
    var myImageView = UIImageView()
    var Posts: [Post] = []
    var indificator = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatadTable(myTable)
        loadData()
    }
    
    private func loadData() {
        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.async {
            self.apiPosts.request { [weak self] result in
                switch result {
                case .failure(let error):
                print(error)
                case .success(let data):
                    let posts = try? JSONDecoder().decode([Post].self, from: data)
                    print(posts?.count ?? 0)
                    self?.Posts = posts!
                    print(self?.Posts ?? "self.Posts error 36")
                    DispatchQueue.main.async {
                        self?.myTable.reloadData()
                    }
                }
            }
        }
    }

    
    private func creatadTable(_ table: UITableView) {
        table.frame = view.frame
        table.register(CastomCell.self, forCellReuseIdentifier: self.indificator)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 150
        view.addSubview(table)
    }
}

//MARK: - Extension
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Posts.count 
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.indificator, for: indexPath) as? CastomCell else {
            return UITableViewCell()
        }
        let post = Posts[indexPath.row]
        cell.configurate(with: post, with: apiImage)
        return cell
    }
}



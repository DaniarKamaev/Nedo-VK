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
    var indificator = "cell"
    let url = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        //creatadTable(myTable)
        createdImageView(myImageView)
        //myImageView = apiImage.getImage(imageView: myImageView)
        apiPosts.request()
    }
    private func createdImageView(_ imageView: UIImageView) {
        imageView.frame = CGRect(x: 0, y: 100, width: 400, height: 400)
        imageView.center.x = view.center.x
        imageView.backgroundColor = .orange
        let myQuoew = DispatchQueue.global(qos: .utility)
        myQuoew.async {
            let image = self.apiImage.reqest()
            DispatchQueue.main.async {
                imageView.image = image
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: self.indificator, for: indexPath)
        return cell
    }
    
    
}



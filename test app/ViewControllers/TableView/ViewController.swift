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
    var myRefrash = UIRefreshControl()
    var myUpdateView = UIView()
    var Posts: [Post] = []
    var indificator = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatadTable(myTable)
        //updateView(myUpdateView)
        creatadRefrash(myRefrash)
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
                        self?.removeUpdateView(view: self!.myUpdateView, intrval: 1.0)
                    }
                }
            }
        }
    }
    private func removeUpdateView(view: UIView, intrval: TimeInterval = 0.5) {
        UIView.animate(withDuration: intrval) {
            view.alpha = 0.0
        } completion: { (finished) in
            if finished {
                view.removeFromSuperview()
            }
        }
    }
    
    
    private let updateLable: UILabel = {
        let lable = UILabel()
        lable.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        lable.text = "Please Wait..."
        lable.textAlignment = .center
        lable.font = UIFont.boldSystemFont(ofSize: 20)
        return lable
    }()
    
    
    private func updateView(_ View: UIView) {
        View.frame = CGRect(x: 0, y: 100, width: 200, height: 50)
        View.center.x = view.center.x
        View.layer.cornerRadius = 25
        View.alpha = 0.9
        View.backgroundColor = .lightGray
        View.addSubview(updateLable)
        view.addSubview(View)
    }
    
    private func creatadRefrash(_ refrash: UIRefreshControl) {
        refrash.tintColor = .gray
        refrash.attributedTitle = NSAttributedString(string: "")
        refrash.addTarget(self, action: #selector(refrashData), for: .valueChanged)
    }

    
    private func creatadTable(_ table: UITableView) {
        table.frame = view.frame
        table.register(CastomCell.self, forCellReuseIdentifier: self.indificator)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 150
        table.refreshControl = myRefrash
        view.addSubview(table)
    }
    //MARK: - Selectors
    @objc func refrashData() {
        updateView(myUpdateView)
        self.loadData()
            self.myRefrash.endRefreshing()
        
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
        let post = Posts.randomElement()
        cell.configurate(with: post!, with: apiImage)
        return cell
    }
}

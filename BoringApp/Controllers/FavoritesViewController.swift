//
//  FavoritesViewController.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 28.09.2021.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let tableView: UITableView = UITableView()
    var savedData: [SavedBoredActivity] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        configureFavoritesViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        savedData = DataBaseManager.shared.savedData ?? []
        tableView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    
    func configureFavoritesViewController() {
        view.backgroundColor = UIColor.systemBackground
    }
    
    func configureTableView() {
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.clear
//        tableView.frame = self.view.bounds
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(BoringCell.self, forCellReuseIdentifier: BoringCell.reuseID)
    }
}

extension FavoritesViewController {
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}


extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BoringCell.reuseID) as! BoringCell
        
        cell.set(with: savedData[indexPath.row])
        
        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

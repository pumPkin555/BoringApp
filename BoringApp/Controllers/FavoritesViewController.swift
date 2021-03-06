//
//  FavoritesViewController.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 28.09.2021.
//

import UIKit
import SafariServices

class FavoritesViewController: UIViewController, UIViewControllerProtocol, SFSafariViewControllerDelegate {
    
    //MARK: - Properties
    
    let tableView: UITableView = UITableView()
    var savedData: [SavedBoredActivity] = []
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.savedData = DataBaseManager.shared.savedData ?? []
            self.animateTableView()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    
    //MARK: - Configure User Interface
    
    func configureViewController() {
        view.backgroundColor = UIColor(named: "SmoothGreen_2")
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "Favorites"
    }
    
    func configureTableView() {
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.clear
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(BoringCell.self, forCellReuseIdentifier: BoringCell.reuseID)
    }
    
    // MARK: - Animations
    
    private func animateTableView() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableViewWidth = tableView.bounds.width
        var delay: Double = 0
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: tableViewWidth, y: 0)
            
            UIView.animate(withDuration: 1.1,
                           delay: delay * 0.05,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                cell.transform = CGAffineTransform.identity
            }
            delay += 1
        }
    }
    
    //MARK: - Open Safari
    
    private func openSafariWithLink(with link: String) {
        if let url = URL(string: link) {
            let safariVC = SFSafariViewController(url: url)
            safariVC.delegate = self
            
            present(safariVC, animated: true, completion: nil)
        }
    }
}

//MARK: - Constraints

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

//MARK: - TableViewDataSource


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

//MARK: - TableViewDelegate

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height * 0.7
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (savedData[indexPath.row].link != "") {
            openSafariWithLink(with: savedData[indexPath.row].link!)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            DataBaseManager.shared.deleteFromEntity(with: savedData[indexPath.row])
            savedData.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

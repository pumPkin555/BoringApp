//
//  ViewController.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 21.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var card: CardView = CardView(title: "Jopa", backgroundColor: UIColor.systemBlue, labelBackgroundColor: UIColor.systemRed)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureCardView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    
    private func configureView() {
        view.backgroundColor = UIColor.systemYellow
    }
    
    private func configureCardView() {
        view.addSubview(card)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            card.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65),
            card.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            card.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            card.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
//    @objc private func tapped() {
//        boredManager.fetchData { (result) in
//            switch result {
//            case .success(let activity):
//                DispatchQueue.main.async {
//                    self.myButton.setTitle(activity.key, for: .normal)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }


}


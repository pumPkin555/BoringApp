//
//  ViewController.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 21.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var card: CardView = CardView(backgroundColor: UIColor.systemGray6)
    let refreshImageView: MyImageView = MyImageView(image: UIImage(systemName: SFSymbols.arrowClockwiseCircle.rawValue) ?? UIImage())
    
    let boredManager: BoredManager = BoredManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureCardView()
        configureRefreshImageView()
        configurePanGestureRecognizer()
        fetchData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    
    private func configureView() {
        view.backgroundColor = UIColor.systemBackground
    }
    
    private func configureCardView() {
        view.addSubview(card)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        
        card.addGestureRecognizer(tap)
    }
    
    private func configureRefreshImageView() {
        view.addSubview(refreshImageView)
        
        refreshImageView.alpha = 1
    }
    
    private func configurePanGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(increaseObject))
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            card.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            card.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            card.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            card.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            refreshImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            refreshImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            refreshImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            refreshImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
    private func fetchData() {
        boredManager.fetchData { (result) in
            switch result {
            case .success(let activity):
                DispatchQueue.main.async {
                    self.card.set(activity: activity.activity, activityType: activity.type, quantity: activity.participants, price: "\(activity.price)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc private func tapped() {
        fetchData()
    }
    
    @objc private func increaseObject(recognizer: UIPanGestureRecognizer) {
        
//        var startPoint: CGFloat?
//        var endPoint: CGFloat?
        
        if (recognizer.state == .began) {
            let translation = recognizer.translation(in: self.view)
            print("Gesture began, \(translation.y)")
        } else if (recognizer.state == .changed) {
            print("Changed!")
//            let translation = recognizer.translation(in: self.view)
        } else if (recognizer.state == .ended) {
            let translation = recognizer.translation(in: self.view)
            print("Ended, \(translation.y)")
        }
        
//        print("Diff: \(endPoint!) - \(startPoint!) = \(endPoint! - startPoint!)")
    }
}


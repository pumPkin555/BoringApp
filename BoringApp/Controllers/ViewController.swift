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
    let filterButton: BoringButton = BoringButton()
    
    let boredManager: BoredManager = BoredManager()
    
    var isNeedToFetch: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureFilterButton()
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
    }
    
    private func configureRefreshImageView() {
        view.addSubview(refreshImageView)
    }
    
    private func configureFilterButton() {
        view.addSubview(filterButton)
        
        filterButton.set(image: UIImage(systemName: SFSymbols.filer.rawValue) ?? UIImage())
        filterButton.addTarget(self, action: #selector(presentSettingsViewController), for: .touchUpInside)
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
        
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            filterButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            filterButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
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
    
    @objc private func increaseObject(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        
        if (recognizer.state == .began) {
        } else if (recognizer.state == .changed) {
            
            if (translation.y + self.card.frame.maxY > self.card.frame.maxY) {

            } else if (self.card.frame.minY > self.view.frame.minY + 25) {
                increase(with: abs(translation.y))
                let newY = translation.y
                self.card.transform = CGAffineTransform(translationX: 0, y: newY)
                self.isNeedToFetch = true
            }
        } else if (recognizer.state == .ended) {
            UIView.animate(withDuration: 0.2, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []) {
                self.card.transform = .identity
                self.refreshImageView.transform = .identity
            }
            
            if (self.isNeedToFetch) {
                self.fetchData()
                self.isNeedToFetch = false
            }
        }
    }
    
    private func increase(with translationValue: CGFloat) {
        let coeff: CGFloat = 0.03
        let scale = abs(translationValue) * coeff
        
        if (scale > 1 && self.refreshImageView.frame.width * scale <= 80) {
            self.refreshImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            print("width:", self.refreshImageView.frame.width)
        }
    }
    
    @objc private func presentSettingsViewController() {
        let settingsVC = SettingsViewController()
        self.present(settingsVC, animated: true, completion: nil)
    }
}

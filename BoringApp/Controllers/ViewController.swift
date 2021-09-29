//
//  ViewController.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 21.09.2021.
//

import UIKit
import CoreData
import SafariServices

class ViewController: UIViewController, UIViewControllerProtocol, SFSafariViewControllerDelegate {

    var card: CardView = CardView()
    let refreshImageView: MyImageView = MyImageView(image: UIImage(systemName: SFSymbols.arrowClockwiseCircle.rawValue) ?? UIImage())
    let filterButton: BoringButton = BoringButton()
    let favoritesButton: BoringButton = BoringButton()
    
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    let animation: CABasicAnimation = CABasicAnimation(keyPath: "locations")
    
    let boredManager: BoredManager = BoredManager()
    var boredModel: BoredActivity?
    
    var tempPrice: Double? = nil
    var tempType: Types? = nil
    var tempParticipants: Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureGradient()
        configureFavoritesButton()
        configureFilterButton()
        configureCardView()
        configureRefreshImageView()
        configurePanGestureRecognizer()
        
        fetchData(type: self.tempType, participants: self.tempParticipants, price: self.tempPrice)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    
    //MARK: - Configure User Interface
    
    func configureViewController() {
        view.backgroundColor = UIColor.clear
    }
    
    private func configureGradient() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.locations = [-0.3, 0.4, 0.65]
        gradientLayer.colors = [UIColor(named: "MoonLight Asteroid_1")!.cgColor, UIColor(named: "MoonLight Asteroid_2")!.cgColor, UIColor(named: "MoonLight Asteroid_3")!.cgColor]
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        animation.fromValue = [-0.3, 0.4, 0.65]
        animation.toValue = [0.5, 1.4, 2.8]
        animation.autoreverses = true
        animation.duration = 4
        animation.repeatCount = .infinity
        
        gradientLayer.add(animation, forKey: nil)
    }
    
    private func configureCardView() {
        view.addSubview(card)
        card.delegate = self
    }
    
    private func configureRefreshImageView() {
        view.addSubview(refreshImageView)
    }
    
    private func configureFavoritesButton() {
        view.addSubview(favoritesButton)
        
        favoritesButton.set(image: UIImage(systemName: SFSymbols.star.rawValue) ?? UIImage(), tintColor: UIColor.label, link: nil)
        favoritesButton.addTarget(self, action: #selector(presentFavoritesViewController), for: .touchUpInside)
    }
    
    private func configureFilterButton() {
        view.addSubview(filterButton)
        
        filterButton.set(image: UIImage(systemName: SFSymbols.filer.rawValue) ?? UIImage(), tintColor: UIColor.label, link: nil)
        filterButton.addTarget(self, action: #selector(presentSettingsViewController), for: .touchUpInside)
    }
    
    private func configurePanGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(moveCard))
        self.card.addGestureRecognizer(panGestureRecognizer)
    }
    
    // MARK: - Fetch Data API
    
    private func fetchData(type: Types?, participants: Int?, price: Double?) {
        DispatchQueue.global(qos: .background).async {
            self.boredManager.fetchData(type: type, participants: participants, price: price) { [weak self] (result) in
                guard let self = self else { return }
                
                switch result {
                case .success(let activity):
                    DispatchQueue.main.async {
                        self.boredModel = activity
                        self.card.set(with: activity)
                    }
                case .failure(let error):
                    self.presentCustomAlert(title: "Error", message: error.rawValue)
                }
            }
        }
    }
    
    //MARK: - Support functions
    
    private func rotate(_ view: UIView, tag: Int) {
        let diff = self.view.center.x - self.card.center.x
        var coeff: CGFloat = 0
        
        if tag == 1 {
            coeff = (self.view.frame.width / 2) / 15
        } else {
            coeff = (self.view.frame.width / 2) / 0.4
        }
        view.transform = CGAffineTransform(rotationAngle: -diff / coeff)
    }
    
    private func saveToDB(with model: BoredActivity?) {
        guard let newModel = model else {
            self.presentCustomAlert(title: "Error", message: "Can't save this… 😞")
            return
        }
        DataBaseManager.shared.saveActivity(with: newModel)
    }
    
    //MARK: - Objective-C functions
    
    @objc private func moveCard(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        
        if (recognizer.state == .changed) {
            
            rotate(self.card, tag: 0)
            rotate(self.refreshImageView, tag: 1)
            
            let newX = card.center.x + translation.x
            let newY = card.center.y
            
            self.card.center = CGPoint(x: newX, y: newY)
            recognizer.setTranslation(.zero, in: self.view)
            
        } else if (recognizer.state == .ended) {
            
            if (self.card.center.x > self.view.frame.width - 20) {
                UIView.animate(withDuration: 0.2) {
                    self.card.center.x += self.view.frame.width
                } completion: { (done) in
                    self.fetchData(type: self.tempType,
                                   participants: self.tempParticipants,
                                   price: self.tempPrice)
                    self.card.alpha = 0
                }
            } else if (self.card.center.x < 20) {
                UIView.animate(withDuration: 0.2) {
                    self.card.center.x -= self.view.frame.width
                } completion: { (done) in
                    self.saveToDB(with: self.boredModel)
                    self.fetchData(type: self.tempType,
                                   participants: self.tempParticipants,
                                   price: self.tempPrice)
                    self.card.alpha = 0
                    
                }
            }
            
            
            UIView.animate(withDuration: 0.2, delay: 0.3, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []) {
                self.card.center = CGPoint(x: self.view.center.x,
                                           y: self.view.center.y)
                
                self.card.transform = .identity
                self.refreshImageView.transform = .identity
            } completion: { (_) in
                UIView.animate(withDuration: 0.1, delay: 0.3) {
                    self.card.alpha = 1
                }
            }
        }
    }
    
    @objc private func openSafariWithLink(with link: String) {
        if let url = URL(string: link) {
            let safariVC = SFSafariViewController(url: url)
            safariVC.delegate = self
            
            present(safariVC, animated: true, completion: nil)
        }
    }
    
    @objc private func presentFavoritesViewController() {
        let favoritesVC = FavoritesViewController()
        let navController = UINavigationController(rootViewController: favoritesVC)
        
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc private func presentSettingsViewController() {
        let settingsVC = SettingsViewController()
        settingsVC.delegate = self
        
        self.present(settingsVC, animated: true, completion: nil)
    }
}

//MARK: - Constraints

extension ViewController {
    func setUpConstraints() {
        
        gradientLayer.frame = view.bounds
        
        NSLayoutConstraint.activate([
            card.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            card.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            card.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            card.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            refreshImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            refreshImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.07),
            refreshImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.07),
            refreshImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            favoritesButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            favoritesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            favoritesButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            favoritesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            filterButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            filterButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
}

//MARK: - Open Safari

extension ViewController: BoringButtonDelegate {
    func set(link: String) {
        openSafariWithLink(with: link)
    }
}

//MARK: - Update Data with filter

extension ViewController: SettingsDelegate {
    func set(model: HalfBoredActivity) {
        self.tempParticipants = model.participants
        self.tempType = model.type
        self.tempPrice = model.price
        
        fetchData(type: self.tempType,
                  participants: self.tempParticipants,
                  price: self.tempPrice)
    }
}

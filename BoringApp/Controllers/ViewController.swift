//
//  ViewController.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 21.09.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var card: CardView = CardView(backgroundColor: UIColor.systemGray6)
    let refreshImageView: MyImageView = MyImageView(image: UIImage(systemName: SFSymbols.arrowClockwiseCircle.rawValue) ?? UIImage())
    let filterButton: BoringButton = BoringButton()
    
    let boredManager: BoredManager = BoredManager()
    var boredModel: BoredActivity?
    
    var isNeedToFetch: Bool = false
    
    var tempPrice: Double? = nil
    var tempType: Types? = nil
    var tempParticipants: Int? = nil
    
    var gradientLayer: CAGradientLayer! {
        didSet {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            gradientLayer.locations = [0.0, 0.4, 0.8]
            gradientLayer.colors = [UIColor(named: "MoonLight Asteroid_1")!.cgColor, UIColor(named: "MoonLight Asteroid_2")!.cgColor, UIColor(named: "MoonLight Asteroid_3")!.cgColor]
        }
    }
    var animation: CABasicAnimation! {
        didSet {
            animation.fromValue = [0.0, 0.4, 0.8]
            animation.toValue = [0.3, 0.7, 1.5]
            animation.autoreverses = true
            animation.duration = 3
            animation.repeatCount = .infinity
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureFilterButton()
        configureCardView()
        configureRefreshImageView()
        configurePanGestureRecognizer()
        
        fetchData(type: self.tempType, participants: self.tempParticipants, price: self.tempPrice)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getDataFromSettingsVC(notification:)), name: .halfBoredParticipants, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openSafariWithLink(notification:)), name: .link, object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    
    private func configureView() {
        view.backgroundColor = UIColor.systemBackground
        gradientLayer = CAGradientLayer()
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        animation = CABasicAnimation(keyPath: "locations")
        gradientLayer.add(animation, forKey: nil)
    }
    
    private func configureCardView() {
        view.addSubview(card)
    }
    
    private func configureRefreshImageView() {
        view.addSubview(refreshImageView)
    }
    
    private func configureFilterButton() {
        view.addSubview(filterButton)
        
        filterButton.set(image: UIImage(systemName: SFSymbols.filer.rawValue) ?? UIImage(), tintColor: UIColor.white, link: nil)
        filterButton.addTarget(self, action: #selector(presentSettingsViewController), for: .touchUpInside)
    }
    
    private func configurePanGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(increaseObject))
        self.card.addGestureRecognizer(panGestureRecognizer)
    }
    
    private func fetchData(type: Types?, participants: Int?, price: Double?) {
        boredManager.fetchData(type: type, participants: participants, price: price) { (result) in
            switch result {
            case .success(let activity):
                DispatchQueue.main.async {
                    self.boredModel = activity
                    self.card.set(with: activity)
                }
            case .failure(let error):
                print(error)
                self.presentAlert(title: "Error", message: error.rawValue)
            }
        }
    }
    
    @objc private func increaseObject(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        
        if (recognizer.state == .began) {
            print("Gesture began")
        } else if (recognizer.state == .changed) {
            rotate(self.card, with: translation.y)
            
            let newX = card.center.x + translation.x
            let newY = card.center.y
            
            self.card.center = CGPoint(x: newX, y: newY)
            recognizer.setTranslation(.zero, in: self.view)
        } else if (recognizer.state == .ended) {
            
            if (self.card.center.x > self.view.frame.width - 20) {
                UIView.animate(withDuration: 0.2) {
                    self.card.center.x += self.view.frame.width * 2
                } completion: { (_) in
                    self.isNeedToFetch = true
                }
            } else if (self.card.center.x < 20) {
                UIView.animate(withDuration: 0.2) {
                    self.card.center.x -= self.view.frame.width * 2
                } completion: { (_) in
                    guard let model = self.boredModel else { return }
                    DataBaseManager.shared.saveActivity(with: model)
                    self.isNeedToFetch = true
                }
            }
            
            
            UIView.animate(withDuration: 0.2, delay: 0.3, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []) {
                self.card.center = CGPoint(x: self.view.center.x,
                                           y: self.view.center.y)
                
                self.card.transform = .identity
                self.refreshImageView.transform = .identity
            }

            if (self.isNeedToFetch) {
                self.fetchData(type: self.tempType,
                               participants: self.tempParticipants,
                               price: self.tempPrice)
                
                self.isNeedToFetch = false
            }
        }
    }
    
    private func increase(_ view: UIView, with translationValue: CGFloat) {
        let coeff: CGFloat = 0.03
        let scale = abs(translationValue) * coeff
        
        if (scale > 1 && self.refreshImageView.frame.width * scale <= 80) {
            view.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    private func rotate(_ view: UIView, with translateionValue: CGFloat) {
        let diff = self.view.center.x - self.card.center.x
        let coeff = (self.view.frame.width / 2) / 0.4
        
        view.transform = CGAffineTransform(rotationAngle: -diff / coeff)
    }
    
    @objc private func getDataFromSettingsVC(notification: Notification) {
        let half = notification.object as! HalfBoredActivity
        
        self.tempParticipants = half.participants
        self.tempType = half.type
        self.tempPrice = half.price
        
        fetchData(type: self.tempType,
                  participants: self.tempParticipants,
                  price: self.tempPrice)
    }
    
    @objc private func openSafariWithLink(notification: Notification) {
        print("Link: ", notification.object)
    }
    
    @objc private func presentSettingsViewController() {
        let settingsVC = SettingsViewController()
        self.present(settingsVC,
                     animated: true,
                     completion: nil)
    }
    
    //MARK: - Constraints
    
    private func setUpConstraints() {
        
        gradientLayer.frame = view.bounds
        
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
}

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
    let refreshImageView: MyImageView = MyImageView(image: SFSymbols.arrowClockwiseCircle!)
    let filterButton: BoringButton = BoringButton()
    let favoritesButton: BoringButton = BoringButton()
    let loader: UIActivityIndicatorView = UIActivityIndicatorView()
    let stackViewItem = UIStackView()
    
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    let animation: CABasicAnimation = CABasicAnimation(keyPath: "locations")
    
    let boredManager: BoredManager = BoredManager()
    var boredModel: BoredActivity?
    
    var tempFilter: HalfBoredActivity? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureGradient()
        configureCardView()
        configureRefreshImageView()
        configureGestureRecognizer()
        
        make(.invisible, a: self.card)
        
        fetchData(with: self.tempFilter)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    
    //MARK: - Configure User Interface
    
    func configureViewController() {
        view.backgroundColor = UIColor.clear
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor.label
        
        navigationItem.titleView = configureTopItemStack()
        
        let filterButton = UIBarButtonItem(image: SFSymbols.filer!,
                                           style: .plain,
                                           target: self,
                                           action: #selector(presentSettingsViewController))
        let favouritesButton = UIBarButtonItem(image: SFSymbols.star!,
                                               style: .plain,
                                               target: self,
                                               action: #selector(presentFavoritesViewController))
        
        navigationItem.leftBarButtonItem = favouritesButton
        navigationItem.rightBarButtonItem = filterButton
    }
    
    private func configureGradient() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.locations = [-0.3, 0.4, 0.65]
        gradientLayer.colors = [UIColor(named: "MoonLight Asteroid_1")!.cgColor,
                                UIColor(named: "MoonLight Asteroid_2")!.cgColor,
                                UIColor(named: "MoonLight Asteroid_3")!.cgColor]
        
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
    
    private func configureGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                          action: #selector(moveCard))
        self.card.addGestureRecognizer(panGestureRecognizer)
    }
    
    private func configureTopItemStack() -> UIView {
        
        stackViewItem.axis = .horizontal
        stackViewItem.spacing = 2
        stackViewItem.distribution = .fillProportionally
        
        let loadingLabel: UILabel = UILabel()
        loadingLabel.text = "Loading…"
        loadingLabel.tintColor = UIColor.label
        loadingLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        loader.startAnimating()
        
        stackViewItem.addArrangedSubview(loader)
        stackViewItem.addArrangedSubview(loadingLabel)
        
        return stackViewItem
    }
    
    // MARK: - Fetch Data API
    
    private func fetchData(with filter: HalfBoredActivity?) {
        
        self.make(.visible, a: self.stackViewItem)
        
        DispatchQueue.global(qos: .background).async {
            self.boredManager.fetchData(with: filter) { [weak self] (result) in
                guard let self = self else { return }
                
                switch result {
                case .success(let activity):
                    DispatchQueue.main.async {
                        self.boredModel = activity
                        self.card.set(with: activity)

                        self.make(.visible, a: self.card)
                        self.make(.invisible, a: self.stackViewItem)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.presentCustomAlert(title: "Error", message: error.rawValue)
                        
                        self.tempFilter = nil
                        
                        self.make(.visible, a: self.card)
                        self.make(.invisible, a: self.stackViewItem)
                    }
                }
            }
        }
    }
    
    //MARK: - Support functions
    
    private func make(_ state: ViewState, a view: UIView) {
        switch state {
        case .visible:
            UIView.animate(withDuration: 1.0) {
                view.isHidden = false
            }
        case .invisible:
            UIView.animate(withDuration: 1.0) {
                view.isHidden = true
            }
        }
    }
    
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
            self.presentCustomAlert(title: "Error",
                                    message: "Can't save this… 😞")
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
            
            self.card.center = CGPoint(x: newX,
                                       y: newY)
            recognizer.setTranslation(.zero, in: self.view)
            
        } else if (recognizer.state == .ended) {
            
            if (self.card.center.x > self.view.frame.width - 20) {
                UIView.animate(withDuration: 0.2) {
                    self.card.center.x += self.view.frame.width
                } completion: { _ in
                    self.fetchData(with: self.tempFilter)

                    self.make(.invisible, a: self.card)
                }
            } else if (self.card.center.x < 20) {
                UIView.animate(withDuration: 0.2) {
                    self.card.center.x -= self.view.frame.width
                } completion: { _ in
                    self.saveToDB(with: self.boredModel)
                    self.fetchData(with: self.tempFilter)

                    self.make(.invisible, a: self.card)
                }
            }
            
            
            UIView.animate(withDuration: 0.2, delay: 0.3, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []) {
                self.card.center = CGPoint(x: self.view.center.x,
                                           y: self.view.center.y)
                
                self.card.transform = .identity
                self.refreshImageView.transform = .identity
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

        self.navigationController?.pushViewController(favoritesVC, animated: true)
    }
    
    @objc private func presentSettingsViewController() {
        let settingsVC = SettingsViewController()
        settingsVC.delegate = self
        
        present(settingsVC, animated: true, completion: nil)
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
        self.tempFilter = model
        self.fetchData(with: self.tempFilter)
    }
}

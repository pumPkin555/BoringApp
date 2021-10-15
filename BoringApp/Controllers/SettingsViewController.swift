//
//  SettingsViewController.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 23.09.2021.
//

import UIKit

class SettingsViewController: UIViewController, UIViewControllerProtocol {
    
    //MARK: - Properties
    
    let typeLabel: UILabel = UILabel()
    var collectionView: UICollectionView!
    let settingsBlock: SettingsViewBlock = SettingsViewBlock()
    let discardButton: UIButton = UIButton()
    let doneButton: UIButton = UIButton()
    
    let color = [
        UIColor.yellow, UIColor.orange, UIColor.systemTeal, UIColor.systemBlue,
        UIColor.systemPink, UIColor.systemGray2, UIColor.systemGray,
        UIColor.tertiarySystemFill, UIColor.systemGreen
    ]

    let titles: [Types] = Types.allCases
    
    var delegate: SettingsDelegate?
    
    var tempTypes: [Types] = [Types]()
    var tempParticipants: Int? = nil
    var tempPrice: (Double, Double)? = nil
    
    enum Section {
        case main
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Types>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Types>
    
    private lazy var dataSource = configureDataSource()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTypeLabel()
        configureCollectionTypeBlock()
        configureSettingsBlock()
        
        applySnapshot()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getType(notification:)),
                                               name: .typeName,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getParticipants(notification:)),
                                               name: .participants,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getPrice(notification:)),
                                               name: .price,
                                               object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    
    //MARK: - Configure User Interface
    
    func configureViewController() {
        view.backgroundColor = UIColor(named: "SmoothGreen_2")
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor.label
        
        title = "Settings"
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(dismissController))
        let resetButton = UIBarButtonItem(title: "Reset",
                                          style: .done,
                                          target: self,
                                          action: #selector(discardFilter))
        
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = resetButton
    }
    
    private func configureTypeLabel() {
        self.view.addSubview(typeLabel)
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.backgroundColor = UIColor.clear
        typeLabel.text = "TYPE"
        typeLabel.textAlignment = .left
        typeLabel.textColor = UIColor.secondaryLabel
    }
    
    private func configureCollectionTypeBlock() {
        collectionView = UICollectionView(frame: CGRect(x: 0,
                                                        y: 50,
                                                        width: self.view.bounds.width,
                                                        height: self.view.bounds.height * 0.25),
                                          collectionViewLayout: UIHelper.configureThreeFlowLayout(in: self.view))
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        
        collectionView.delegate = self
        
        collectionView.register(BoringCollectionViewCell.self,
                                forCellWithReuseIdentifier: BoringCollectionViewCell.reuseID)
        
        view.addSubview(collectionView)
    }
    
    private func configureSettingsBlock() {
        view.addSubview(settingsBlock)
    }
    
    private func configureDiscardButton() {
        view.addSubview(discardButton)
        
        discardButton.translatesAutoresizingMaskIntoConstraints = false
        discardButton.backgroundColor = UIColor.systemPurple
        discardButton.setTitle("Discard filters", for: .normal)
        discardButton.layer.cornerRadius = 10
        discardButton.layer.masksToBounds = true
        
        discardButton.addTarget(self, action: #selector(discardFilter), for: .touchUpInside)
    }
    
    private func configureDoneButton() {
        view.addSubview(doneButton)
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.backgroundColor = UIColor.systemBlue
        doneButton.setTitle("Done", for: .normal)
        doneButton.layer.cornerRadius = 10
        doneButton.layer.masksToBounds = true

        doneButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
    }
    
    //MARK: - Diffable DataSource
    
    private func configureDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: self.collectionView) { (collectionView, indexPath, type) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoringCollectionViewCell.reuseID, for: indexPath) as! BoringCollectionViewCell
            
            cell.set(color: self.color[indexPath.row], text: type.rawValue)

            return cell
        }
        
        return dataSource
    }
    
    private func applySnapshot() {
        var snapShot = SnapShot()
        snapShot.appendSections([.main])
        snapShot.appendItems(titles)
        
        dataSource.apply(snapShot)
    }
    
    //MARK: - Objective-C functions
    
    @objc private func getPrice(notification: Notification) {
        let type = notification.object as! Price
        switch type {
        case .cheap(let min, let max):
            self.tempPrice = (min, max)
        case .average(let min, let max):
            self.tempPrice = (min, max)
        }
    }
    
    @objc private func getType(notification: Notification) {
        let tempType = notification.object as? Types
        if let type = tempType {
            self.tempTypes.append(type)
        }
    }
    
    @objc private func getParticipants(notification: Notification) {
        self.tempParticipants = notification.object as? Int
    }
    
    @objc func discardFilter() {
        tempTypes = [Types]()
        tempParticipants = nil
        tempPrice = nil
        
        let model = HalfBoredActivity(type: self.tempTypes,
                                      participants: self.tempParticipants,
                                      price: self.tempPrice)
        delegate?.set(model: model)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissController() {
        
        if (self.tempTypes != [] || self.tempParticipants != nil || self.tempPrice != nil) {
            let model = HalfBoredActivity(type: self.tempTypes,
                                          participants: self.tempParticipants,
                                          price: self.tempPrice)
            delegate?.set(model: model)
        }
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Constraints

extension SettingsViewController {
    
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70),
            typeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            typeLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95),
            typeLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.03)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.typeLabel.bottomAnchor, constant: 0),
            collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0),
            collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25)
        ])
        
        NSLayoutConstraint.activate([
            settingsBlock.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0),
            settingsBlock.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsBlock.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65),
            settingsBlock.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95)
        ])
    }
}

// MARK: - CollectionView Delegate

extension SettingsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! BoringCollectionViewCell
        guard let type = dataSource.itemIdentifier(for: indexPath) else { return }
        
        if (cell.chosen()) {
            if let index = self.tempTypes.firstIndex(of: type) {
                self.tempTypes.remove(at: index)
            }
        } else {
            self.tempTypes.append(type)
        }
        
        cell.select()
    }
}

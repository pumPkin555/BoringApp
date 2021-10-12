//
//  CollectionTypeBlock.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 10.10.2021.
//

import UIKit

class CollectionTypeBlock: UIView {

    let color = [UIColor.yellow, UIColor.orange, UIColor.systemTeal, UIColor.purple, UIColor.systemPink, UIColor.systemGray2, UIColor.systemGray, UIColor.tertiarySystemFill]
    let titles: [Types] = Types.allCases
    
    var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCollectionTypeBlock()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        configureCollectionView()
    }
    
    private func configureCollectionTypeBlock() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.systemBlue
    }
    
    func configureCollectionView() {
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height), collectionViewLayout: UIHelper.configureThreeFlowLayout(in: self))
        
        self.addSubview(collectionView)
        
        collectionView.backgroundColor = UIColor.clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        collectionView.register(BoringCollectionViewCell.self, forCellWithReuseIdentifier: BoringCollectionViewCell.reuseID)
    }
}

extension CollectionTypeBlock: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoringCollectionViewCell.reuseID,
                                                      for: indexPath) as! BoringCollectionViewCell
        
        cell.set(color: color[indexPath.row],
                 text: titles[indexPath.row].rawValue)
        
        return cell
    }
}

extension CollectionTypeBlock: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Tapped at \(indexPath.row), \(titles[indexPath.row].rawValue) 😝")
    }
}

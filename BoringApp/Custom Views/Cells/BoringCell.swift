//
//  BoringCell.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 28.09.2021.
//

import UIKit

class BoringCell: UITableViewCell, UIViewProtocol {
    
    static let reuseID: String = "BoringCell"
    
    private let card: CardView = CardView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpConstraints()
    }
    
    //MARK: - Configure UI
    
    func configureView() {
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.contentView.addSubview(self.card)
    }
    
    //MARK: - Set card with model
    
    func set(with model: SavedBoredActivity) {
        self.card.set(with: model)
        
        configureView()
    }
    
    //MARK: - Constraints
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            card.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.9),
            card.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.9),
            card.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            card.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
}

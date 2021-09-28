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
    
    func configureView() {
        self.contentView.addSubview(self.card)
        
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = UIColor.systemGray6
    }
    
    func set(with model: SavedBoredActivity) {
        self.card.set2(with: model)
        
        configureView()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            card.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.9),
            card.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.9),
            card.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            card.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
}

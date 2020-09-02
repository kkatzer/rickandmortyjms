//
//  ListCharactersViewCell.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 01/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

class ListCharactersViewCell: UICollectionViewCell {
    
    let image: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    let status: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(named: "Gray 1")
        view.font = UIFont.systemFont(ofSize: 11)
        return view
    }()
    
    let title: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(named: "Black")
        view.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        view.numberOfLines = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListCharactersViewCell: CodeView {
    func buildViewHierarchy() {
        addSubview(image)
        addSubview(status)
        addSubview(title)
    }
    
    func setupConstraints() {
        let constraints = [
            //image
            image.leftAnchor.constraint(equalTo: self.leftAnchor),
            image.rightAnchor.constraint(equalTo: self.rightAnchor),
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: (1/1.15)),
            
            //status
            status.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            status.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 12),
            status.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 12),
            
            //title
            title.leftAnchor.constraint(equalTo: status.leftAnchor),
            title.rightAnchor.constraint(equalTo: status.rightAnchor),
            title.topAnchor.constraint(equalTo: status.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupAdditionalConfiguration() {
        layer.borderColor = UIColor(named: "Gray 5")?.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        backgroundColor = UIColor(named: "White")
    }
}

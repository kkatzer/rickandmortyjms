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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    let status: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
        view.font = UIFont.systemFont(ofSize: 11)
        return view
    }()
    
    let title: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = #colorLiteral(red: 0.03137254902, green: 0.1215686275, blue: 0.1960784314, alpha: 1)
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
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: (1/1.15)),
            
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
        layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
        layer.borderWidth = 1
        layer.cornerRadius = 8
        backgroundColor = UIColor(named: "White")
    }
}

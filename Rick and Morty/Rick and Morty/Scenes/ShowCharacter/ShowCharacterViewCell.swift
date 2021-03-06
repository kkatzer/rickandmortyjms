//
//  ShowCharacterViewCell.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 03/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

class ShowCharacterViewCell: UITableViewCell {
    
    lazy var title: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = #colorLiteral(red: 0.03137254902, green: 0.1215686275, blue: 0.1960784314, alpha: 1)
        view.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return view
    }()
    
    lazy var subtitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
        view.font = UIFont.systemFont(ofSize: 15)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ShowCharacterViewCell: CodeView {
    func buildViewHierarchy() {
        addSubview(title)
        addSubview(subtitle)
    }
    
    func setupConstraints() {
        let constraints = [
            //title
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 9),
            
            //subtitle
            subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor),
            subtitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupAdditionalConfiguration() {
        
    }
    
    
}

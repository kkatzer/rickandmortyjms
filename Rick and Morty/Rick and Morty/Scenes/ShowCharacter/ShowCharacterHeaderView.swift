//
//  ShowCharacterHeaderView.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 03/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

class ShowCharacterHeaderView: UIView {
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        return view
    }()
    
    lazy var headerImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "headerImage")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var avatar: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.borderWidth = 5
        view.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        view.layer.masksToBounds = false
        view.layer.cornerRadius = view.frame.height/2
        view.clipsToBounds = true
        return view
    }()
    
    lazy var status: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
        view.font = UIFont.systemFont(ofSize: 13)
        return view
    }()
    
    lazy var name: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = #colorLiteral(red: 0.03137254902, green: 0.1215686275, blue: 0.1960784314, alpha: 1)
        view.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return view
    }()
    
    lazy var species: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
        view.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return view
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ShowCharacterHeaderView: CodeView {
    func buildViewHierarchy() {
        headerView.addSubview(headerImage)
        headerView.addSubview(avatar)
        headerView.addSubview(status)
        headerView.addSubview(name)
        headerView.addSubview(species)
        addSubview(headerView)
    }
    
    func setupConstraints() {
        let cons = [
            //headerView
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            //headerImage
            headerImage.topAnchor.constraint(equalTo: headerView.topAnchor),
            headerImage.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            headerImage.rightAnchor.constraint(equalTo: headerView.rightAnchor),
            
            //avatar
            avatar.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 19),
            avatar.heightAnchor.constraint(equalToConstant: 150),
            avatar.widthAnchor.constraint(equalToConstant: 150),
            avatar.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            //status
            status.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 20),
            status.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            //name
            name.topAnchor.constraint(equalTo: status.bottomAnchor),
            name.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            //species
            species.topAnchor.constraint(equalTo: name.bottomAnchor),
            species.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            species.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20),
        ]
        
        NSLayoutConstraint.activate(cons)
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = UIColor(named: "White")
    }
    
    
}

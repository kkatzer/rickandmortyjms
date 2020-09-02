//
//  ListCharactersView.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 01/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

class ListCharactersView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        super.init(frame: frame, collectionViewLayout: layout)
        setupView()
        
//        register(CollectionCell.self, forCellWithReuseIdentifier: "characterCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListCharactersView: CodeView {
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .red
    }
}

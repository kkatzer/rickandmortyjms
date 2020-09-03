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
        backgroundColor = .white
        
        register(ListCharactersViewCell.self, forCellWithReuseIdentifier: "CharacterCollectionViewCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

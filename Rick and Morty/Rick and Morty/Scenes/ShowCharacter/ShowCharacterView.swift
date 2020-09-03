//
//  ShowCharacterView.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 03/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

class ShowCharacterView: UITableView {
    
    override init(frame: CGRect = .zero, style: UITableView.Style = .grouped) {
        super.init(frame: frame, style: .grouped)
        
        register(ShowCharacterViewCell.self, forCellReuseIdentifier: "CharacterTableViewCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

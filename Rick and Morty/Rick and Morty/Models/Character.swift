//
//  Character.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 01/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

struct Character {
    init(id: Int, name: String, status: String, species: String? = nil, type: String? = nil, gender: String? = nil, origin: String? = nil, location: String? = nil, image: String, favorite: Bool) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.favorite = favorite
    }
    
    let id: Int
    let name: String
    let status: String
    let species: String?
    let type: String?
    let gender: String?
    let origin: String?
    let location: String?
    let image: String
    let favorite: Bool
}

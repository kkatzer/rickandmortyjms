//
//  Character.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 01/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

struct Character: Equatable {
    init(id: Int, name: String, status: String, species: String, type: String, gender: String, origin: String, location: String, image: String, favorite: Bool) {
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
    let species: String
    let type: String
    let gender: String
    let origin: String
    let location: String
    let image: String
    var favorite: Bool
}

func ==(lhs: Character, rhs: Character) -> Bool {
    return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.status == rhs.status
        && lhs.species == rhs.species
        && lhs.type == rhs.type
        && lhs.gender == rhs.gender
        && lhs.origin == rhs.origin
        && lhs.location == rhs.location
        && lhs.image == rhs.image
        && lhs.favorite == rhs.favorite
}

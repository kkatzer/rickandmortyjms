//
//  ShowCharacterModels.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 02/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

enum ShowCharacter {
    // MARK: Use cases
    
    enum GetCharacter {
        
        struct Request {
        }
        
        struct Response {
            var character: Character
        }
        
        struct ViewModel {
            struct DisplayedCharacter {
                var id: Int
                var name: String
                var status: String
                var species: String
                var type: String
                var gender: String
                var origin: String
                var location: String
                var image: String
                var favorite: Bool
            }
            var displayedCharacter: DisplayedCharacter
        }
    }
    
    enum ToggleFavoriteCharacter {
        
        struct Request {
        }
        
        struct Response {
            var favorite: Bool
        }
        
        struct ViewModel {
            var favorite: Bool
        }
    }
}

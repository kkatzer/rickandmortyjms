//
//  ListCharactersModels.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 01/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

enum ListCharacters {
    // MARK: Use cases
    
    enum FetchCharacters {
        
        struct Request {
            var isFirstPage: Bool
        }
        
        struct Response {
            var characters: [Character]
        }
        
        struct ViewModel {
            struct DisplayedCharacter {
                var id: Int
                var name: String
                var status: String
                var image: String
            }
            var displayedCharacters: [DisplayedCharacter]
        }
    }
}

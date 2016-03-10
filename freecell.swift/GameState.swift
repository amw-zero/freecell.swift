//
//  GameState.swift
//  freecell.swift
//
//  Created by Alex Weisberger on 3/10/16.
//  Copyright © 2016 AMW. All rights reserved.
//

import Foundation

struct GameState {
    var cascades: Cascades
    var free_cells: [Card]
    var foundations: [Card]
}
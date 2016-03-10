//
//  GameState.swift
//  freecell.swift
//
//  Created by Alex Weisberger on 3/10/16.
//  Copyright © 2016 AMW. All rights reserved.
//

import Foundation

class GameState {
    var cascades: Cascades
    var free_cells: [Card]
    var foundations: [Card]
    
    init(cascades: Cascades, free_cells: [Card], foundations: [Card]) {
        self.cascades = cascades
        self.free_cells = free_cells
        self.foundations = foundations
    }
    
    func perform_move(move: Move) {
        switch move {
        case .SingleCardMove(let source_cascade_idx, let dest_cascade_idx):
            var source_cascade = cascades[source_cascade_idx]
            var dest_cascade = cascades[dest_cascade_idx]

            // if legal move
            // var card = source_cascade.last
            guard let card = source_cascade.popLast() else {
                print("GameState: No card in cascade")
                return
            }
            
            
            
            dest_cascade.append(card)
            print(source_cascade)
            print(dest_cascade)
            
            // TODO: Why is this necessary ?? Weird Array value/reference behavior
            cascades[source_cascade_idx] = source_cascade
            cascades[dest_cascade_idx] = dest_cascade
            
        default: print("GameState: Unrecognized move")
        }
    }
}


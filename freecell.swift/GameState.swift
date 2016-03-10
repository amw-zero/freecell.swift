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
            
            // TODO: Why is this necessary ?? Weird Array value/reference behavior
            cascades[source_cascade_idx] = source_cascade
            cascades[dest_cascade_idx] = dest_cascade
            
        case .FreeCellMove(let source_cascade_idx):
            if free_cells.count >= 4 {
                return
            }
            
            var source_cascade = cascades[source_cascade_idx]
            if let card = source_cascade.popLast() {
                free_cells.append(card)
            }
            
            
            // WHYYY??
            cascades[source_cascade_idx] = source_cascade
        }
    }
    
    func render() {
        print_free_cells(free_cells)
        
        print("")
        print("")
        
        print_cascades(cascades)
    }
}

func print_free_cells(cards: [Card]) {
    for i in 0 ... 3 {
        if i < cards.count {
            print(" [\(cards[i])] ", terminator: "")
        } else {
            print(" [ ]  ", terminator: "")
        }

    }
    
}

func print_cascades(cascades: Cascades) {
    var j = 0
    let max_cascade = cascades.reduce(0) { (a, cascade) -> Int in
        if cascade.count > a {
            return cascade.count
        } else {
            return a
        }
    }
    while j < max_cascade {
        for i in 0 ... NUM_CASCADES - 1 {
            var cascade = cascades[i]
            if j < cascade.count {
                print(cascade[j], terminator: "")
            } else {
                print("      ", terminator: "")
            }
        }
        print("")
        j++
    }
}


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
    var smily_toggle: Bool = true
    
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
            
            if let source_card = source_cascade.last, dest_card = dest_cascade.last {
                if !is_legal_cascade_move(source_card, dst: dest_card) {
                    print("Illegal move!")
                    return
                }
            }
            
            guard let card = source_cascade.popLast() else {
                print("GameState: No card in cascade")
                return
            }
            
            dest_cascade.append(card)
            
            // TODO: Why is this necessary ?? Weird Array value/reference behavior
            cascades[source_cascade_idx] = source_cascade
            cascades[dest_cascade_idx] = dest_cascade
            
        case .CascadeToFreeCellMove(let source_cascade_idx):
            if free_cells.count >= 4 {
                return
            }
            
            var source_cascade = cascades[source_cascade_idx]
            if let card = source_cascade.popLast() {
                free_cells.append(card)
            }
            
            // Why is this necessary?
            cascades[source_cascade_idx] = source_cascade
            
        case .FreeCellToCascadeMove(let free_cell_idx, let cascade_idx):
            if free_cell_idx >= free_cells.count {
                return
            }
            
            var cascade = cascades[cascade_idx]
            let src_card = free_cells[free_cell_idx]
            
            guard let dst_card = cascade.last else {
                return
            }
            
            if is_legal_cascade_move(src_card, dst: dst_card) {
                let moving_card = free_cells.removeAtIndex(free_cell_idx)
                cascade.append(moving_card)
                cascades[cascade_idx] = cascade
            }
        case .CascadeToFoundationMove:
            break
        }
        smily_toggle = !smily_toggle
    }
    
    func smily_string() -> String {
        if smily_toggle {
            return ":)"
        } else {
            return "(:"
        }
    }
    
    func render() {
        print("")
        print("")
        print("space                                            enter")
        print_cells(free_cells)
        print("   \(smily_string())   ", terminator: "")
        print_cells(foundations)
        print("")
        if (free_cells.count > 0) {
            print_free_cell_labels(free_cells)
        }
        print("")
        print("")
        
        print_cascades(cascades)
    }
}

func print_cells(cards: [Card]) {
    for i in 0 ... 3 {
        if i < cards.count {
            print("[\(cards[i])] ", terminator: "")
        } else {
            print("[  ]  ", terminator: "")
        }
    }
}

func print_free_cell_labels(free_cells: [Card]) {
    for i in 0 ... free_cells.count - 1 {
        if let free_cell_letter = free_cell_letter_from_num(i) {
            print("  \(free_cell_letter)   ", terminator: "")
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
                print("  \(cascade[j])  ", terminator: "")
            } else {
                print("       ", terminator: "")
            }
        }
        print("")
        j++
    }
    print("")
    for i in 0 ... NUM_CASCADES - 1 {
        if let cascade_letter = cascade_letter_from_num(i) {
            print("   \(cascade_letter)   ", terminator: "")
        } else {
            print("Attempted to print out of bounds cascade!")
        }
    }
    print("")
    print("")
}


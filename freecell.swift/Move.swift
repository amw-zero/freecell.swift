//
//  Move.swift
//  freecell.swift
//
//  Created by Alex Weisberger on 3/10/16.
//  Copyright © 2016 AMW. All rights reserved.
//

import Foundation

enum Move {
    case SingleCardMove(Int, Int)
    case FreeCellMove(Int, Card)
}

func cascade_num_from_letter(string: String) -> Int? {
    switch string {
        case "a": return 0
        case "b": return 1
        case "c": return 2
        case "d": return 3
        case "e": return 4
        case "f": return 5
        case "g": return 6
        case "h": return 7
        default: return nil
    }
}

func make_single_card_move(input: String) -> Move? {
    let c1 = String(input[input.startIndex.advancedBy(0)])
    let c2 = String(input[input.startIndex.advancedBy(1)])
    
    guard let source_cascade = cascade_num_from_letter(c1) else {
        return nil
    }
    guard let dest_cascade = cascade_num_from_letter(c2) else {
        return nil
    }
    
    return .SingleCardMove(source_cascade, dest_cascade)
}

func move_from_input(input: String, _ game_state: GameState) -> Move? {
    switch input {
    case let single_card_input where single_card_input.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 3:
        return make_single_card_move(single_card_input)
    default: return nil
    }
}

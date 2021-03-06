//
//  Move.swift
//  freecell.swift
//
//  Created by Alex Weisberger on 3/10/16.
//  Copyright © 2016 AMW. All rights reserved.
//

import Foundation

extension String {
    func utf_len() -> Int {
        return lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
    }
}

enum Move {
    case CascadeToCascadeMove(cascade_src_idx: Int, cascade_dst_idx: Int)
    case CascadeToFreeCellMove(cascade_idx: Int)
    case FreeCellToCascadeMove(free_cell_src_idx: Int, cascade_dst_idx: Int)
    case CascadeToFoundationMove(cascade_idx: Int)
    // case FreeCellToFoundationMoves
}

func is_legal_foundation_move(src: Card, dst: Card?) -> Bool {
    if let dest_card = dst {
        let same_suit = src.suit == dest_card.suit
        let dst_one_less_than_src = dest_card.rank.rawValue == src.rank.rawValue - 1
        
        return same_suit && dst_one_less_than_src
    } else if src.rank == .Ace {
        return true
    } else {
        return false
    }
}

func is_legal_cascade_move(src: Card, dst: Card?) -> Bool {
    if let dest_card = dst {
        let dst_one_more_than_src = dest_card.rank.rawValue == src.rank.rawValue + 1
        let opposite_colors = dest_card.suit != src.suit
        
        return dst_one_more_than_src && opposite_colors
    } else {
        return true
    }
}

func make_single_card_move(input: String) -> Move? {
    let c1 = String(input[input.startIndex])
    let c2 = String(input[input.startIndex.advancedBy(1)])
    
    guard let source_cascade = cascade_num_from_letter(c1) else {
        return nil
    }
    guard let dest_cascade = cascade_num_from_letter(c2) else {
        return nil
    }
    
    return .CascadeToCascadeMove(cascade_src_idx: source_cascade, cascade_dst_idx: dest_cascade)
}

func make_free_cell_move(input: String) -> Move? {
    let src_letter = String(input[input.startIndex])
    
    guard let src_idx = cascade_num_from_letter(src_letter) else {
        return nil
    }
    
    return .CascadeToFreeCellMove(cascade_idx: src_idx)
}

func make_free_cell_to_cascade_move(input: String) -> Move? {
    let src_letter = String(input[input.startIndex])
    let dst_letter = String(input[input.startIndex.advancedBy(1)])
    
    guard let src_idx = free_cell_num_from_letter(src_letter) else {
        return nil
    }
    
    guard let dst_idx = cascade_num_from_letter(dst_letter) else {
        return nil
    }
    
    return .FreeCellToCascadeMove(free_cell_src_idx: src_idx, cascade_dst_idx: dst_idx)
}

func make_cascade_to_foundation_move(input: String) -> Move? {
    let src_letter = String(input[input.startIndex])
    guard let src_idx = cascade_num_from_letter(src_letter) else {
        return nil
    }

    return .CascadeToFoundationMove(cascade_idx: src_idx)
}

func move_from_input(input: String) -> Move? {
    switch input {
    case let s
        where s.utf_len() == 3
        && s[s.endIndex.predecessor().predecessor()] == " ":
        
        return make_free_cell_move(input)
        
    case let s
        where s.utf_len() == 3
        && s[s.startIndex] == "w" || s[s.startIndex] == "x" || s[s.startIndex] == "y"
        || s[s.startIndex] == "z":
        
        return make_free_cell_to_cascade_move(s)
        
    case let s
        where s.utf_len() == 3:
        
        return make_single_card_move(s)
        
    case let s
        where s.utf_len() == 2:
        
        return make_cascade_to_foundation_move(s)
        
    default: return nil
    }
}

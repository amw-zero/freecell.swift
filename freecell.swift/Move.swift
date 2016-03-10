//
//  Move.swift
//  freecell.swift
//
//  Created by Alex Weisberger on 3/10/16.
//  Copyright © 2016 AMW. All rights reserved.
//

import Foundation

enum Move {
    case SingleCardMove(cascade_src_idx: Int, cascade_dst_idx: Int)
    case CascadeToFreeCellMove(cascade_idx: Int)
    case FreeCellToCascadeMove(free_cell_src_idx: Int, cascade_dst_idx: Int)
}

func is_legal_free_cell_move(src: Card) -> Bool {
    return false
}

func is_legal_foundation_move(src: Card, dst: Card) -> Bool {
    return false
}
func is_legal_cascade_move(src: Card, dst: Card) -> Bool {
    let dst_one_more_than_src = dst.rank.rawValue == src.rank.rawValue + 1
    let opposite_colors = dst.suit != src.suit
    
    return dst_one_more_than_src && opposite_colors
}

func make_single_card_move(input: String) -> Move? {
    // TODO: A little ugly
    let c1 = String(input[input.startIndex.advancedBy(0)])
    let c2 = String(input[input.startIndex.advancedBy(1)])
    
    guard let source_cascade = cascade_num_from_letter(c1) else {
        return nil
    }
    guard let dest_cascade = cascade_num_from_letter(c2) else {
        return nil
    }
    
    return .SingleCardMove(cascade_src_idx: source_cascade, cascade_dst_idx: dest_cascade)
}

func make_free_cell_move(input: String) -> Move? {
    let src_letter = String(input[input.startIndex.advancedBy(0)])
    
    guard let src_idx = cascade_num_from_letter(src_letter) else {
        return nil
    }
    
    return .CascadeToFreeCellMove(cascade_idx: src_idx)
}

func make_free_cell_to_cascade_move(input: String) -> Move? {
    let src_letter = String(input[input.startIndex.advancedBy(0)])
    let dst_letter = String(input[input.startIndex.advancedBy(1)])
    
    guard let src_idx = free_cell_num_from_letter(src_letter) else {
        return nil
    }
    
    guard let dst_idx = cascade_num_from_letter(dst_letter) else {
        return nil
    }
    
    return .FreeCellToCascadeMove(free_cell_src_idx: src_idx, cascade_dst_idx: dst_idx)
}

func move_from_input(input: String) -> Move? {
    switch input {
    case let free_cell_input
        where free_cell_input.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 3
        && free_cell_input[free_cell_input.endIndex.predecessor().predecessor()] == " ":
        
        return make_free_cell_move(input)
        
    case let n
        where n.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 3
        && n[n.startIndex] == "w" || n[n.startIndex] == "x" || n[n.startIndex] == "y"
        || n[n.startIndex] == "z":
        
        return make_free_cell_to_cascade_move(n)
        
    case let single_card_input
        where single_card_input.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 3:
        
        return make_single_card_move(single_card_input)
        
    default: return nil
    }
}

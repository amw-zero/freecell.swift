//
//  Deck.swift
//  freecell.swift
//
//  Created by Alex Weisberger on 3/9/16.
//  Copyright © 2016 AMW. All rights reserved.
//

import Foundation

typealias Deck = [Card]
typealias DeckArray = [Card]
typealias Cascade = [Card]
typealias Cascades = [Cascade]

let DECK_SIZE = 52
let CARDS_PER_SUIT = 13
let NUM_CASCADES = 8

func create_deck() -> Deck {
    var deck = [Card]()
    for i in 0 ... DECK_SIZE - 1 {
        switch i % 4 {
        case 0: deck.append(Card(Suit.Clubs,    Rank(rawValue: i % 13 + 1)!))
        case 1: deck.append(Card(Suit.Diamonds, Rank(rawValue: i % 13 + 1)!))
        case 2: deck.append(Card(Suit.Hearts,   Rank(rawValue: i % 13 + 1)!))
        case 3: deck.append(Card(Suit.Spades,   Rank(rawValue: i % 13 + 1)!))
        default: break
        }
    }
    
    for i in 0 ... deck.count - 1 {
        let tmp = deck[i]
        let j = Int(arc4random()) % deck.count
        deck[i] = deck[j]
        deck[j] = tmp
    }
    return deck
}

func cascades_from_deck(deck: Deck) -> Cascades {
    var cascades = Cascades()
    
    for _ in 0 ... NUM_CASCADES - 1 {
        cascades.append(Cascade())
    }
    
    for (i, card) in deck.enumerate() {
        let c = i % NUM_CASCADES
        var cascade = cascades[c]
        cascade.append(card)
        cascades[c] = cascade
    }
    
    return cascades
}

func create_cascades() -> Cascades {
    return cascades_from_deck(create_deck())
}

func free_cell_letter_from_num(num: Int) -> String? {
    switch num {
    case 0: return "w"
    case 1: return "x"
    case 2: return "y"
    case 3: return "z"
    default: return nil
    }
}

func free_cell_num_from_letter(letter: String) -> Int? {
    switch letter {
    case "w": return 0
    case "x": return 1
    case "y": return 2
    case "z": return 3
    default: return nil
    }    
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

func cascade_letter_from_num(num: Int) -> String? {
    switch num {
    case 0: return "a"
    case 1: return "b"
    case 2: return "c"
    case 3: return "d"
    case 4: return "e"
    case 5: return "f"
    case 6: return "g"
    case 7: return "h"
    default: return nil
    }
}

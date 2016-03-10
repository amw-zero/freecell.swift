//
//  Deck.swift
//  freecell.swift
//
//  Created by Alex Weisberger on 3/9/16.
//  Copyright © 2016 AMW. All rights reserved.
//

import Foundation

typealias Deck = [Card]

let DECK_SIZE = 52

func create_deck() -> Deck {
    var deck = [Card]()
    for i in 0 ... DECK_SIZE - 1 {
        switch i % 4 {
        case 0: deck.append(Card(suit: Suit.Clubs, rank: Rank(rawValue: i % 13 + 1)!))
        case 1: deck.append(Card(suit: Suit.Diamonds, rank: Rank(rawValue: i % 13 + 1)!))
        case 2: deck.append(Card(suit: Suit.Hearts, rank: Rank(rawValue: i % 13 + 1)!))
        case 3: deck.append(Card(suit: Suit.Spades, rank: Rank(rawValue: i % 13 + 1)!))
        default: break
        }
    }
    
    return deck
}

func print_deck(deck: Deck) {
    for card in deck {
        print(card)
    }
}
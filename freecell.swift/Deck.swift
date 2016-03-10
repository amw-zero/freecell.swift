//
//  Deck.swift
//  freecell.swift
//
//  Created by Alex Weisberger on 3/9/16.
//  Copyright © 2016 AMW. All rights reserved.
//

import Foundation

typealias Deck = [Card]

func create_deck() -> Deck {
    return [Card(suit: Suit.Clubs, rank: Rank.Ace)]
}

func print_deck(deck: Deck) {
    for card in deck {
        print("\(card.rank)")
    }
}
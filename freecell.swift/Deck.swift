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
        case 0: deck.append(Card(Suit.Clubs, Rank(rawValue: i % 13 + 1)!))
        case 1: deck.append(Card(Suit.Diamonds, Rank(rawValue: i % 13 + 1)!))
        case 2: deck.append(Card(Suit.Hearts, Rank(rawValue: i % 13 + 1)!))
        case 3: deck.append(Card(Suit.Spades, Rank(rawValue: i % 13 + 1)!))
        default: break
        }
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
    let deck = create_deck()
    return cascades_from_deck(deck)
}

// TODO: In place shuffle
func shuffle_deck(var deck: Deck) {
    for i in 0 ... DECK_SIZE - 1 {
        let j = Int(arc4random() % 52)
        if i == j {
            continue
        }
        swap(&deck[i], &deck[j])
    }
}
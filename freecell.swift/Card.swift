//
//  Card.swift
//  freecell.swift
//
//  Created by Alex Weisberger on 3/9/16.
//  Copyright © 2016 AMW. All rights reserved.
//

import Foundation

// MARK: Card Characteristics

enum Color {
    case Red
    case Black
}

enum Suit: CustomStringConvertible {
    case Clubs
    case Diamonds
    case Hearts
    case Spades
    
    var description: String {
        switch self {
        case .Clubs:    return "c"
        case .Diamonds: return "d"
        case .Hearts:   return "h"
        case .Spades:   return "s"
        }
    }
}

enum Rank: Int {
    case Ace = 1
    case Two
    case Three
    case Four
    case Five
    case Six
    case Seven
    case Eight
    case Nine
    case Ten
    case Jack
    case Queen
    case King
}

struct Card: CustomStringConvertible, Comparable {
    let suit: Suit
    let rank: Rank
    
    init(_ suit: Suit, _ rank: Rank) {
        self.suit = suit
        self.rank = rank
    }

    // MARK: CustomStringConvertible
    var description: String {
        return String(format: "%2d%@", rank.rawValue, suit.description)
    }
}


// MARK: Comparable
func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.rank.rawValue == rhs.rank.rawValue
}

func <=(lhs: Card, rhs: Card) -> Bool {
    return lhs.rank.rawValue <= rhs.rank.rawValue
}

func >=(lhs: Card, rhs: Card) -> Bool {
    return lhs.rank.rawValue >= rhs.rank.rawValue
}

func >(lhs: Card, rhs: Card) -> Bool {
    return lhs.rank.rawValue > rhs.rank.rawValue
}

func <(lhs: Card, rhs: Card) -> Bool {
    return lhs.rank.rawValue < rhs.rank.rawValue
}

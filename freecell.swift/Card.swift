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

enum Suit {
    case Clubs
    case Diamonds
    case Hearts
    case Spades
}

enum Rank: Int {
    case Ace = 0
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

    // MARK: CustomStringConvertible
    var description: String {
        return "[\(rank.rawValue)] "
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

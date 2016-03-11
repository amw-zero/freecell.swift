//
//  FreeCellTests.swift
//  FreeCellTests
//
//  Created by Alex Weisberger on 3/10/16.
//  Copyright © 2016 AMW. All rights reserved.
//

import XCTest

class FreeCellTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLegalFoundationMoves() {
        let ace = Card(Suit.Clubs, Rank.Ace)
        XCTAssert(is_legal_foundation_move(ace, dst: nil))
        
        let two = Card(Suit.Clubs, Rank.Two)
        XCTAssert(is_legal_foundation_move(two, dst: ace))
        
        let four = Card(Suit.Clubs, Rank.Four)
        XCTAssertFalse(is_legal_foundation_move(four, dst: ace))
        XCTAssertFalse(is_legal_foundation_move(four, dst: nil))
        XCTAssertFalse(is_legal_foundation_move(four, dst: nil))
        XCTAssertFalse(is_legal_foundation_move(two, dst: four))
    }
    
    func testLegalCascadeMoves() {
        let src = Card(Suit.Clubs, Rank.Queen)
        var dst = Card(Suit.Clubs, Rank.Jack)

        XCTAssertFalse(is_legal_cascade_move(src, dst: dst))
        
        dst = Card(Suit.Diamonds, Rank.King)
        XCTAssertTrue(is_legal_cascade_move(src, dst: dst))
        
        XCTAssertTrue(is_legal_cascade_move(src, dst: nil))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}

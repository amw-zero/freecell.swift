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
    
    func test() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let src = Card(Suit.Clubs, Rank.Queen)
        var dst = Card(Suit.Clubs, Rank.Jack)

        XCTAssertFalse(is_legal_cascade_move(src, dst: dst))
        
        dst = Card(Suit.Diamonds, Rank.King)
        XCTAssertTrue(is_legal_cascade_move(src, dst: dst))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}

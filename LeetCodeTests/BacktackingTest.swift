//
//  BacktackingTest.swift
//  LeetCodeTests
//
//  Created by 许龙 on 2019/4/17.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import XCTest
@testable import LeetCode

class BacktackingTest : XCTestCase {
    
    func testPattern() {
        var o = Pattern(["a", "b", "*", "f", "a"], 5)
        XCTAssertFalse(o.match(["a", "b", "a", "b", "a", "a"], 6))
        XCTAssertTrue(o.match(["a", "b", "a", "b", "f", "a"], 6))
        
        o = Pattern(["a", "b", "*"], 3)
        XCTAssertTrue(o.match(["a", "b", "a", "b", "f", "a"], 6))
        
        o = Pattern(["a", "b", "?", "a"], 4)
        XCTAssertTrue(o.match(["a", "b"], 2))
    }
}

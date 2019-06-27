//
//  LinkedListTest.swift
//  LeetCodeTests
//
//  Created by 许龙 on 2019/4/18.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import XCTest
@testable import LeetCode

class LinkedListTest: XCTestCase {
    
    func testLinkedList() {
        let o = LinkedList<Int>()
        o.add(1)
        o.add(2)
        print(o)
        XCTAssert(o.size == 2)
        XCTAssert(o.tail?.val == 2)
        
        o.reverse()
        print(o)
        o.reverse()
        
        o.delete(at: 1)
        print(o)
        XCTAssert(o.size == 1)
        XCTAssert(o.tail?.val == 1)
        
        o.reverse()
        print(o)
        o.reverse()

        o.delete(at: 0)
        print(o)
        XCTAssert(o.size == 0)
        XCTAssert(o.tail == nil)
        
        o.reverse()
        print(o)
        o.reverse()
        
        o.add(1)
        o.add(2)
        o.add(3)
        o.add(4)
        o.add(5)
        o.add(6)
        o.add(7)
        o.add(8)
        print(o)
        o.reverse()
        print(o)
    }
    
    func testDoubleLinkedList() {
        let o = DoubleLinkedList<Int>()
        o.add(1)
        o.add(2)
        print(o)
        XCTAssert(o.size == 2)
        XCTAssert(o.tail?.val == 2)
        
        o.reverse()
        print(o)
        o.reverse()
        
        o.delete(at: 0)
        print(o)
        XCTAssert(o.size == 1)
        XCTAssert(o.tail?.val == 2)
        
        o.reverse()
        print(o)
        o.reverse()
        
        o.delete(at: 0)
        print(o)
        XCTAssert(o.size == 0)
        XCTAssert(o.tail == nil)
        
        o.reverse()
        print(o)
        o.reverse()
        
        o.add(1)
        o.add(2)
        o.add(3)
        o.add(4)
        o.add(5)
        o.add(6)
        o.add(7)
        o.add(8)
        print(o)
        o.reverse()
        print(o)
    }
    
    func testCircularLinkedList() {
        let o = CircularLinkedList<Int>()
        o.add(1)
        o.add(2)
        print(o)
        XCTAssert(o.size == 2)
        XCTAssert(o.tail?.val == 2)

        o.delete(at: 0)
        print(o)
        XCTAssert(o.size == 1)
        XCTAssert(o.tail?.val == 2)

        o.delete(at: 0)
        print(o)
        XCTAssert(o.size == 0)
        XCTAssert(o.tail == nil)

        o.add(1)
        o.add(2)
        o.add(3)
        o.add(4)
        o.add(5)
        o.add(6)
        o.add(7)
        o.add(8)
        print(o)
    }
}

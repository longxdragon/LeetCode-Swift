//
//  ArrayTest.swift
//  LeetCodeTests
//
//  Created by 许龙 on 2019/4/18.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import XCTest
@testable import LeetCode

class ArrayTest: XCTestCase {
    
    func testMutableArray() {
        let arr = MutableArray<Int>(5)
        arr.add(1)
        arr.add(3)
        arr.add(2)
        arr.add(3)
        
        print(arr)
        
        arr.delete(3)
        print(arr)
        
        arr.add(4)
        arr.add(5)
        arr.add(6)
        arr.add(7)
        print(arr)
    }
    
    func testSortedArray() {
        let arr = SortedArray<Int>()
        arr.add(1)
        arr.add(3)
        arr.add(4)
        arr.add(5)
        print(arr)
        
        arr.delete(3)
        print(arr)
        
        arr.add(4)
        arr.add(5)
        arr.add(6)
        arr.add(7)
        print(arr)
        
        arr.delete(4)
        print(arr)
    }
    
}

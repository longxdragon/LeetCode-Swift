//
//  TreeTest.swift
//  LeetCodeTests
//
//  Created by 许龙 on 2019/7/2.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import XCTest
@testable import LeetCode

class TreeTest: XCTestCase {
    
    func testBinarySearchTree() {
        let obj = BinarySearchTree()
        obj.insert(5)
        obj.insert(1)
        obj.insert(3)
        obj.insert(4)
        obj.insert(6)
        obj.insert(2)
        
        print("\npreOrder: ", terminator: "")
        obj.preOrder(obj.tree)
        print("\ninOrder: ", terminator: "")
        obj.inOrder(obj.tree)
        print("\npostOrder: ", terminator: "")
        obj.postOrder(obj.tree)
        
        XCTAssertEqual(obj.findMin()?.val, 1)
        XCTAssertEqual(obj.findMax()?.val, 6)
        
        if let node = obj.find(4) {
            XCTAssertEqual(obj.findPreNode(node)?.val, 3)
            XCTAssertEqual(obj.findNextNode(node)?.val, 5)
        }
        
        XCTAssertNotNil(obj.find(3), "Pass")
        obj.delete(3)
        XCTAssertNil(obj.find(3), "Pass")
        
        print("\npreOrder: ", terminator: "")
        obj.preOrder(obj.tree)
        print("\ninOrder: ", terminator: "")
        obj.inOrder(obj.tree)
        print("\npostOrder: ", terminator: "")
        obj.postOrder(obj.tree)
        print("\nlevelOrder: ", terminator: "")
        obj.levelOrder()
        
        obj.reverse(obj.tree)
        obj.inOrder(obj.tree)
        
        XCTAssertEqual(obj.deep(obj.tree), 4)
        XCTAssertEqual(obj.width(obj.tree), 2)
    }
    
    func testAVLTree() {
        let tree = AVLTree<Int, Int>()
        tree.add(key: 20, val: 200)
        tree.add(key: 10, val: 100)
        tree.add(key: 9, val: 90)
        tree.add(key: 8, val: 80)
        tree.add(key: 7, val: 70)
        tree.add(key: 6, val: 60)
        
        tree.preOrder(node: tree.root)
        tree.inOrder(node: tree.root)
        tree.postOrder(node: tree.root)
        
        print("isBalance = \(tree.isBalance)")
    }
}

//
//  Solution.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/14.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

class Solution {
    
    public func arrayByLinkedList(_ head: ListNode?) -> [Int] {
        var arr = [Int]();
        var node = head;
        while let n = node {
            arr.append(n.val);
            node = n.next;
        }
        return arr;
    }
}

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

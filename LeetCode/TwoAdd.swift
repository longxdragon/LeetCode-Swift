//
//  TwoAdd.swift
//  LeetCode
//
//  Created by 许龙 on 2018/10/24.
//  Copyright © 2018 longxdragon. All rights reserved.
//

import Foundation

/**
 链表实现两个数相加
 https://leetcode-cn.com/problems/add-two-numbers/description/
 */
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class TwoAdd {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var node1: ListNode? = l1
        var node2: ListNode? = l2
        if node1 == nil {
            return node2
        }
        if node2 == nil {
            return node1
        }
        
        var ten = 0
        let head: ListNode? = ListNode.init(0)
        var next: ListNode? = head
        
        while node1 != nil || node2 != nil {
            let v1: Int = node1 == nil ? 0 : node1!.val
            let v2: Int = node2 == nil ? 0 : node2!.val
            var val = v1 + v2 + ten
            ten = val / 10
            val = val % 10
            
            next?.next = ListNode.init(val)
            next = next?.next
            
            node1 = node1?.next
            node2 = node2?.next
        }
        if ten == 1 {
            next?.next = ListNode.init(1)
        }
        
        return head?.next
    }
}

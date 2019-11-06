//
//  0002. Add Two Numbers.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/30.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 2. 两数相加
 https://leetcode-cn.com/problems/add-two-numbers/
 */
extension Solution {
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var node1 = l1, node2 = l2;
        var ten = 0;
        let head: ListNode = ListNode.init(0);
        var tail = head;
        
        while node1 != nil || node2 != nil {
            let v1 = node1?.val ?? 0;
            let v2 = node2?.val ?? 0;
            var val = v1 + v2 + ten;
            if val >= 10 {
                ten = 1;
                val -= 10;
            } else {
                ten = 0;
            }
            
            tail.next = ListNode.init(val);
            tail = tail.next!;
            
            node1 = node1?.next;
            node2 = node2?.next;
        }
        if ten == 1 {
            tail.next = ListNode.init(1);
        }
        return head.next;
    }
}

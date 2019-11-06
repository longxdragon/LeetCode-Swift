//
//  0141. Linked List Cycle.swift
//  LeetCode
//
//  Created by 许龙 on 2019/11/6.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 141. 环形链表
 https://leetcode-cn.com/problems/linked-list-cycle/
 */
extension Solution {
    /* 快慢指针 */
    func hasCycle(_ head: ListNode?) -> Bool {
        var fast = head;
        var slow = head;
        while let f = fast, let s = slow {
            if f === s {
                return true;
            }
            fast = f.next?.next;
            slow = s.next;
        }
        return false;
    }
}

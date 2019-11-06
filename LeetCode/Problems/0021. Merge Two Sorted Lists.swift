//
//  0021. Merge Two Sorted Lists.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/31.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 21. 合并两个有序链表
 https://leetcode-cn.com/problems/merge-two-sorted-lists/

 时间复杂度：O(N+M)
 控件复杂度：O(1)
 */
extension Solution {
    
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let head = ListNode(0);
        var tail = head;
        var p = l1, q = l2;
        while let n1 = p, let n2 = q {
            if n1.val < n2.val {
                tail.next = n1;
                tail = n1;
                p = n1.next;
            } else {
                tail.next = n2;
                tail = n2;
                q = n2.next;
            }
        }
        if let n1 = p {
            tail.next = n1;
        }
        if let n2 = q {
            tail.next = n2;
        }
        return head.next;
    }
}

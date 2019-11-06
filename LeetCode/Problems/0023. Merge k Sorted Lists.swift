//
//  0023. Merge k Sorted Lists.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/31.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 23. 合并K个排序链表
 https://leetcode-cn.com/problems/merge-k-sorted-lists/
 
 时间复杂度：O(N*logK)
 空间复杂度：O(1)
 */
extension Solution {
    
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        var lst = lists;
        var interval = 1;
        while interval < lst.count {
            // 0 ..< lst.count - interval
            // 两两合并
            for i in stride(from: 0, to: lst.count - interval, by: 2 * interval) {
                lst[i] = merge2Lists(lst[i], lst[i + interval]);
            }
            interval *= 2;
        }
        return lst[0];
    }
    
    /**
     分治递归实现
     由于要压栈，所以空间复杂度并不完全是O(1)
     */
    func mergeKListsWithDivide(_ list: [ListNode?], _ left: Int, _ right: Int) -> ListNode? {
        if left == right {
            return list[left];
        }
        let mid = left + (right - left)/2;
        let l1 = mergeKListsWithDivide(list, left, mid);
        let l2 = mergeKListsWithDivide(list, mid + 1, right);
        return merge2Lists(l1, l2);
    }
    
    private func merge2Lists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
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

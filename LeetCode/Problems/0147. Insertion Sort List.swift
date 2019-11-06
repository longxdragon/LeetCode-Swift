//
//  0147. Insertion Sort List.swift
//  LeetCode
//
//  Created by 许龙 on 2019/11/1.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 147. 对链表进行插入排序
 https://leetcode-cn.com/problems/insertion-sort-list/
 
 时间复杂度：O(N*N)
 空间复杂度：O(1)
 */
extension Solution {
    
    func insertionSortList(_ head: ListNode?) -> ListNode? {
        guard let h = head else {
            return nil;
        }
        var sorted_head = h;
        var sorted_tail = h;
        var curr = h.next;
        while let node = curr {
            let next = node.next;
            // 先跟最后一个比较，比有序的最后一个大，就直接跳过
            // 从而达到 O(N) 的时间复杂度
            if node.val >= sorted_tail.val {
                sorted_tail = node;
            } else {
                sorted_tail.next = next;
                
                var p: ListNode?;
                var c: ListNode? = sorted_head;
                while let n = c, n.val <= node.val {
                    p = c;
                    c = n.next;
                }
                if let prev = p {
                    node.next = c;
                    prev.next = node;
                } else {
                    node.next = c;
                    sorted_head = node;
                }
            }
            curr = next;
        }
        return sorted_head;
    }
}

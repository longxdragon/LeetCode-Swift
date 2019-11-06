//
//  0148. Sort List.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/31.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 148. 排序链表
 https://leetcode-cn.com/problems/sort-list/
 
 时间复杂度：O(N*logN)
 控件复杂度：O(1)
 */
extension Solution {
    
    func sortList(_ head: ListNode?) -> ListNode? {
        var len = 0;
        var node = head;
        while let p = node {
            node = p.next;
            len += 1;
        }
        
        let newHead = ListNode(0);
        newHead.next = head;
        
        var interval = 1;
        while interval < len {
            var curr = newHead.next;
            var tail: ListNode? = newHead;
            while let node = curr {
                // 每隔几个切割链表
                let left = node;
                let right = cuteList(node, interval);
                curr = cuteList(right, interval);
                // 合并两个子链表
                tail?.next = merge2List(left, right);
                while let next = tail?.next {
                    tail = next;
                }
            }
            interval *= 2;
        }
        return newHead.next;
    }
    
    /** 截取从 n 开始往后的链表 */
    private func cuteList(_ head: ListNode?, _ n: Int) -> ListNode? {
        var p = head;
        var count = 1;
        while count < n {
            p = p?.next;
            count += 1;
        }
        let next = p?.next;
        p?.next = nil;
        return next;
    }
    
    private func merge2List(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
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

//
//  0025. Reverse Nodes in k-Group.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/30.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 25. K 个一组翻转链表
 https://leetcode-cn.com/problems/reverse-nodes-in-k-group/
 */
extension Solution {
    
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        if k == 1 || head == nil {
            return head;
        }
        // 不足 K 个，保持原有顺序
        var count = 1;
        var node: ListNode? = head;
        while count < k {
            node = node?.next;
            count += 1;
        }
        guard let _ = node else {
            return head;
        }
        // 翻转 K 个
        count = 0;
        var prev: ListNode? = nil;
        var curr: ListNode? = head;
        var next: ListNode? = nil;
        while count < k {
            next = curr?.next;
            curr?.next = prev;
            prev = curr;
            curr = next;
            count += 1;
        }
        if curr != nil {
            head?.next = reverseKGroup(curr, k);
        }
        return prev;
    }
}

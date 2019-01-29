//
//  Node.swift
//  LeetCode
//
//  Created by 许龙 on 2018/10/30.
//  Copyright © 2018 longxdragon. All rights reserved.
//

import Foundation

// 定义链表
class Node<T> {
    var val: T?
    var next: Node?
    
    init(val: T) {
        self.val = val
    }
}

class LinkedNode {
    func combine(_ node1: Node<Int>, _ node2: Node<Int>) -> Node<Int>? {
        var head1: Node<Int>? = node1
        var head2: Node<Int>? = node2
        let ret: Node<Int> = Node(val: 0)
        var tail: Node<Int> = ret
        
        if head1 == nil {
            return head2
        }
        if head2 == nil {
            return head1
        }
        
        while head1 != nil && head2 != nil {
            if head1!.val! < head2!.val! {
                tail.next = head1
                head1 = head1?.next
            } else {
                tail.next = head2
                head2 = head2?.next
            }
            tail = tail.next!
        }
        
        if head2 != nil {
            tail.next = head2
        }
        if head1 != nil {
            tail.next = head1
        }
        
        return ret.next
    }
}

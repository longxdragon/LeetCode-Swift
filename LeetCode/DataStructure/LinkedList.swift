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

/**
 ******* 链表 *******
 */
class LinkedList<T> {
    
    private var head: Node<T>?
    private var tail: Node<T>?
    
    var size: Int {
        var count = 0
        var node = head
        while let n = node {
            count += 1
            node = n.next
        }
        return count
    }
    
    var isEmpty: Bool {
        return head == nil
    }
    
    func add(_ node: Node<T>) {
        if isEmpty {
            head = node
            tail = head
        } else {
            tail?.next = node
            tail = tail?.next
        }
    }
    
    func getValue(_ i: Int) -> T? {
        var index = i
        var p: Node<T>? = head
        while index > 0 {
            p = p?.next
            index -= 1
        }
        return p?.val
    }
    
    
    /**
     两个有序链表的合并
     */
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

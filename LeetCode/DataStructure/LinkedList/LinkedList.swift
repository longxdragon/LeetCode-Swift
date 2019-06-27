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
    var val: T
    var next: Node?
    weak var previous: Node?
    
    init(val: T) {
        self.val = val
    }
}

/**
 ************** 单链表 **************
 */
class LinkedList<T> {
    
    public var head: Node<T>?
    
    /// 返回尾节点
    public var tail: Node<T>? {
        var node = head
        while let next = node?.next {
            node = next
        }
        return node
    }
    
    /// 返回节点个数
    public var size: Int {
        var node = head
        var count = 0
        while let nd = node {
            count += 1
            node = nd.next
        }
        return count
    }
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    /// 返回对应下标的节点
    public func node(at index: Int) -> Node<T> {
        assert(head != nil, "list is empty")
        assert(index >= 0, "index must greater or equal to 0")
        
        var node = head
        for _ in 0..<index {
            node = node?.next
            if node == nil {
                break
            }
        }
        assert(node != nil, "index is out of bounds")
        return node!
    }
    
    /// 添加节点
    public func add(_ val: T) {
        let node = Node(val: val)
        self.add(node)
    }
    
    public func add(_ node: Node<T>) {
        if let last = tail { // 注意尾节点是否存在
            last.next = node
        } else {
            head = node
        }
    }
    
    /// 删除节点
    public func delete(at index: Int) {
        let node = self.node(at: index)
        delete(node)
    }
    
    public func delete(_ node: Node<T>) {
        guard var n = head else {
            return
        }
        if n === node { // 删除的是头结点
            head = n.next
        } else {
            while let next = n.next {
                if next === node {
                    n.next = next.next
                    break
                }
                n = next
            }
        }
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
            if head1!.val < head2!.val {
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

extension LinkedList : CustomStringConvertible {
    
    public var description: String {
        var str = ""
        if var node = head {
            str += "-> \(node.val) "
            
            while let next = node.next {
                str += "-> \(next.val) "
                node = next
            }
        }
        return str
    }
}

extension LinkedList {
    /// 链表的反转
    public func reverse() {
        guard var node = head else {
            return
        }
        
        var prev: Node<T>? = nil
        while let next = node.next {
            node.next = prev
            prev = node
            node = next
        }
        node.next = prev
        head = node
    }
}

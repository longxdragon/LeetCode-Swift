//
//  DoubleLinkedList.swift
//  LeetCode
//
//  Created by 许龙 on 2019/4/19.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 ************** 双向链表 **************
 */
class DoubleLinkedList<T> {
    
    public var head: Node<T>?
    
    /** ----- 这部分同单链表 ----- */
    public var tail: Node<T>? {
        var node = head
        while let next = node?.next {
            node = next
        }
        return node
    }
    
    var size: Int {
        var node = head
        var count = 0
        while let nd = node {
            count += 1
            node = nd.next
        }
        return count
    }
    
    var isEmpty: Bool {
        return head == nil
    }
    
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
    /** ----- ----------- ----- */
    
    /// 添加节点
    public func add(_ val: T) {
        let node = Node(val: val)
        self.add(node)
    }
    
    public func add(_ node: Node<T>) {
        if let last = tail {
            last.next = node
            node.previous = last
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
        let prev = node.previous
        let next = node.next
        
        if let prevv = prev {
            prevv.next = next
        } else { // 删除的是头节点
            head = next
        }
        next?.previous = prev
        
        node.next = nil
        node.previous = nil
    }
}

extension DoubleLinkedList : CustomStringConvertible {
    
    public var description: String {
        var str = ""
        if var node = head {
            str += "-> \(node.val) "
            
            while let next = node.next {
                str += "-> \(next.val)"
                node = next
            }
        }
        return str
    }
}

extension DoubleLinkedList {
    /// 双向链表的反转
    public func reverse() {
        var node = head
        while let current = node {
            // 前后指针交换
            let next = current.next
            current.next = current.previous
            current.previous = next
            
            node = next
            // 更新头结点
            head = current
        }
    }
}

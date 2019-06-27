//
//  CircularLinkedList.swift
//  LeetCode
//
//  Created by 许龙 on 2019/4/18.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 ************** 双向循环链表 **************
 */
class CircularLinkedList<T> {
    
    public var head: Node<T>?
    
    public var tail: Node<T>? {
        var node = head
        while let next = node?.next, next !== head {
            node = next
        }
        return node
    }
    
    public var size: Int {
        // 头结点储存东西，所以需要多加判断
        guard var node = head else {
            return 0
        }
        var count: Int = 1
        while let next = node.next, next !== head {
            count += 1
            node = next
        }
        return count
    }
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public func node(at index: Int) -> Node<T> {
        assert(head != nil, "list is empty")
        assert(index >= 0, "index must greater or equal to 0")
        
        var node = head
        for _ in 0..<index {
            node = node?.next
            if node === head { // 循环链表的 tail 节点指向 head 节点
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
        if let last = tail {
            last.next = node
            node.previous = last
            node.next = head
            head?.previous = node
        } else {
            head = node
            node.next = node
            node.previous = node
        }
    }
    
    /// 删除节点
    public func delete(at index: Int) {
        let node = self.node(at: index)
        delete(node)
    }
    
    public func delete(_ node: Node<T>) {
        let next = node.next
        let prev = node.previous
        
        if node === head {
            if node === next { // 删除的是头结点，并且只有一条数据
                head = nil
            } else {
                head = next
            }
        }
        next?.previous = prev
        prev?.next = next
        
        node.next = nil
        node.previous = nil
    }
}

extension CircularLinkedList : CustomStringConvertible {
    
    public var description: String {
        var str = ""
        if var node = head {
            str += "-> \(node.val) "
            
            while let next = node.next, next !== head { // 循环列表的 tail 指向 head
                str += "-> \(next.val)"
                node = next
            }
        }
        return str
    }
}

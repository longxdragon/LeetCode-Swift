//
//  LinkedQueue.swift
//  LeetCode
//
//  Created by 许龙 on 2018/10/30.
//  Copyright © 2018 longxdragon. All rights reserved.
//

import Foundation

// 链表实现的 - 链式队列
class LinkedQueue<T> {
    typealias Element = T
    var head: Node<Element>?
    var tail: Node<Element>?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var size: Int {
        var count = 0
        var node = head
        while let n = node {
            count += 1
            node = n.next
        }
        return count
    }
    
    func enqueue(_ item: Element) {
        let node = Node.init(val: item)
        if isEmpty {
            head = node
            tail = node
        } else {
            tail?.next = node
            tail = tail?.next
        }
    }
    
    func dequeue() -> Element? {
        if isEmpty {
            return nil
        }
        let node = head
        head = head?.next
        return node?.val
    }
}

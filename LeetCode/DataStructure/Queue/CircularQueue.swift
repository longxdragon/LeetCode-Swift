//
//  CircularQueue.swift
//  LeetCode
//
//  Created by 许龙 on 2018/10/30.
//  Copyright © 2018 longxdragon. All rights reserved.
//

import Foundation

// 循环队列
class CircularQueue<Element> {
    private var items = [Element]()
    private var n = 0
    private var head = 0
    private var tail = 0
    var size = 0
    
    init(_ defaultElement: Element, _ capacity: Int) {
        items = Array(repeating: defaultElement, count: capacity)
        n = capacity
    }
    
    func enqueue(_ item: Element) -> Bool {
        if size == n {
            return false
        }
        items[tail] = item
        size += 1
        tail += 1
        
        // 循环
        if tail >= n {
            tail %= n
        }
        return true
    }
    
    func dequeue() -> Element? {
        if tail == head {
            return nil
        }
        let item = items[head]
        head += 1
        size -= 1
        
        // 循环
        if head >= 0 {
            head %= n
        }
        return item
    }
}

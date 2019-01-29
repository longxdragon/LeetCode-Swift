//
//  ArrayQueue.swift
//  LeetCode
//
//  Created by 许龙 on 2018/10/30.
//  Copyright © 2018 longxdragon. All rights reserved.
//

import Foundation

// 数组实现的队列 - 顺序队列
class ArrayQueue<Element> {
    private var items = [Element]()
    private var n = 0
    private var head = 0
    private var tail = 0
    
    init(_ defaultElement: Element, _ capacity: Int) {
        items = Array(repeating: defaultElement, count: capacity)
        n = capacity
    }
    
    // 浪费空间，就算有空间，tail到了数组的尾部，也不能s往队列插入数据
    func enqueue(_ item: Element) -> Bool {
        if tail == n {
            // 搬数据
            if head > 0 {
                for index in head..<tail {
                    let i: Int = index - head
                    items[i] = items[index]
                }
                tail -= head
                head = 0
            }
            // 搬完数据后，依然还是没有空间了，就提示插入失败
            if tail == n {
                return false
            }
        }
        items[tail] = item
        tail += 1
        return true
    }
    
    func dequeue() -> Element? {
        if tail == head {
            return nil
        }
        let item = items[head]
        head += 1
        return item
    }
}

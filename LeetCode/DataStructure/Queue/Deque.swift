//
//  Deque.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/18.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

// 双端队列
class Deque<T> {
    private var array: [T?];
    private var capacity = 0;
    private let originalCapacity: Int;
    private var head = 0;
    
    init(_ capacity: Int = 10) {
        self.capacity = capacity;
        array = [T?](repeating: nil, count: capacity);
        head = capacity;
        originalCapacity = capacity;
    }
    
    var isEmpty: Bool {
        return self.count == 0;
    }
    
    var count: Int {
        return array.count - head;
    }
    
    public func enqueue(_ element: T) {
        array.append(element);
    }
    
    public func enqueueFront(_ element: T) {
        if head == 0 {
            capacity *= 2;
            let arr = [T?](repeating: nil, count: capacity);
            array.insert(contentsOf: arr, at: 0);
            head = capacity;
        }
        head -= 1;
        array[head] = element;
    }
    
    @discardableResult public func dequeue() -> T? {
        guard head < array.count, let element = array[head] else {
            return nil;
        }
        array[head] = nil;
        head += 1;
        
        if capacity >= originalCapacity && head >= capacity * 2 {
            let amountToRemove = capacity + capacity/2;
            array.removeFirst(amountToRemove);
            head -= amountToRemove;
            capacity /= 2;
        }
        return element;
    }
    
    @discardableResult public func dequeueBack() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeLast()
        }
    }
    
    public func peekFront() -> T? {
        if isEmpty {
            return nil;
        } else {
            return array[head];
        }
    }
    
    public func peekBack() -> T? {
        return array.last ?? nil;
    }
}

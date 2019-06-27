//
//  MutbaleArray.swift
//  LeetCode
//
//  Created by 许龙 on 2019/4/18.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 ************** 支持动态扩容的数组 **************
 */
class MutableArray<T: Comparable> {
    
    var list: [T?]
    var capacity: Int
    var count: Int
    
    init(_ capacity: Int) {
        self.list = [T?](repeating: nil, count: capacity)
        self.capacity = capacity
        self.count = 0
    }
    
    func add(_ item: T) {
        if count >= capacity {
            // 扩容 + 搬数据
            var list = self.list
            self.list = [T?](repeating: nil, count: capacity*2)
            for i in 0..<count {
                self.list[i] = list[i]
            }
        }
        self.list[count] = item
        count += 1
    }
    
    func delete(_ item: T) {
        if count == 0 {
            return
        }
        // 找到要删除的元素下标
        var index = -1
        for i in 0..<count {
            if let o = self.list[i], o == item {
                index = i
                break
            }
        }
        if index == -1 {
            return
        }
        // 搬数据
        for i in index..<count {
            self.list[i] = self.list[i+1]
        }
        
        count -= 1
        self.list[count] = nil
    }
    
    func get(_ index: Int) -> T? {
        if index < count {
            return self.list[index]
        }
        return nil
    }
    
}

extension MutableArray : CustomStringConvertible {
    
    public var description: String {
        return self.list.description
    }
}

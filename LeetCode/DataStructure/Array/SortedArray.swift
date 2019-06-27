//
//  SortedArray.swift
//  LeetCode
//
//  Created by 许龙 on 2019/4/18.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 ************** 有序数组 **************
 */
class SortedArray<T: Comparable> {
    
    private var list: [T]
    
    public var count: Int {
        return self.list.count
    }
    
    init() {
        self.list = [T]()
    }
    
    @discardableResult public func add(_ item: T) -> Int {
        let index = bSearch(item)
        self.list.insert(item, at: index)
        return index
    }
    
    public func delete(_ item: T) {
        let index = bSearch(item);
        if self.list[index] != item { // 删除的元素，数组中未找到
            return
        }
        self.delete(at: index)
    }
    
    public func delete(at index: Int) {
        guard index < count else {
            return
        }
        self.list.remove(at: index)
    }
    
    
    public func get(_ index: Int) -> T? {
        if index < count {
            return self.list[index]
        }
        return nil
    }
    
    // 二分查找 -> 找到需要插入或者删除的下标
    private func bSearch(_ item: T) -> Int {
        var low = 0
        var high = count - 1
        
        while low <= high {
            let mid = low + (high - low)/2
            if item < self.list[mid] {
                high = mid - 1
            } else if item > self.list[mid] {
                low = mid + 1
            } else {
                return mid
            }
        }
        return low
    }
}

extension SortedArray : CustomStringConvertible {
    
    public var description: String {
        return self.list.description
    }
}

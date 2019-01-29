//
//  HashTable.swift
//  LeetCode
//
//  Created by 许龙 on 2018/12/24.
//  Copyright © 2018 longxdragon. All rights reserved.
//

import Foundation


/**
 HashTable - “散列表”：数组+Hash函数充分结合的数据结构
 时间复杂度：
          平均      最坏
 Space:   O(n)     O(n)
 Search:  O(1)     O(n)
 Insert:  O(1)     O(n)
 Delete:  O(1)     O(n)
 
 */
/**
 ----------------- 开放寻址 -> 线性探测 --------------------
 */
class LineHashTable<Key: Hashable, Value> {
    
    private typealias Element = (key: Key, val: Value, deleted: Bool)
    private var table: [Element?]
    private var oldTable: [Element?]?
    
    private var capacity: Int
    private var factor: Float
    private var row: Int = 0
    
    public var size: Int = 0
    
    public var isEmpty: Bool { return size == 0 }
    
    init(_ capacity: Int, _ factor: Float) {
        self.capacity = capacity
        self.factor = factor
        self.table = [Element?](repeating: nil, count: capacity)
    }
    
    /**
     插入的时候
     Note: 是覆盖还是新增，如果是匹配到相同的 key，就是替换；否则 table 无数据，就是添加
     */
    public subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
        set {
            if let value = newValue {
                updateValue(value, forKey: key)
            } else {
                removeValue(forKey: key)
            }
        }
    }
    
    /**
     查询的时候，根据 keys 数组去查找
     */
    public func value(forKey key: Key) -> Value? {
        // 1、先去老的数组中查找
        if let t = oldTable {
            var index = hash(key) % t.count
            while let k = t[index], k.key != key {
                index = (index + 1) % t.count
            }
            if let item = t[index], !item.deleted {
                return item.val
            }
        }
        
        // 2、找不到就去新的数组中查找
        var index = hash(key) % capacity
        while let k = table[index], k.key != key {
            index = (index + 1) % capacity
        }
        if let item = table[index], !item.deleted {
            return item.val
        } else {
            return nil
        }
    }
    
    /**
     移除的时候，只是把 deleted 标记改成 true
     Note: 方便遍历查找
     */
    @discardableResult public func removeValue(forKey key: Key) -> Value? {
        // 1、先移除老数组中的数据
        if let t = oldTable {
            var index = hash(key) % t.count
            while let k = t[index], k.key != key {
                index = (index + 1) % t.count
            }
            if let item = t[index], !item.deleted {
                // 由于是元祖类型，是值类型，不能直接修改 item 的值
                oldTable?[index]?.deleted = true
                size -= 1
                return item.val
            }
        }
        
        // 2、移除新数组中的数据
        var index = hash(key) % capacity
        while let k = table[index], k.key != key {
            index = (index + 1) % capacity
        }
        if let item = table[index], !item.deleted {
            table[index]?.deleted = true
            size -= 1
            return item.val
        } else {
            return nil
        }
    }
    
    /**
     更新 key 对应的 value,
     */
    @discardableResult public func updateValue(_ value: Value, forKey key: Key) -> Value? {
        // 1、扩容，直接把数据插入到新数组中
        let n: Int = Int(Float(capacity) * factor)
        if size >= n {
            capacity = 2 * capacity
            oldTable = table
            table = [Element?](repeating: nil, count: capacity)
        }
        
        // 2、移除之前相同的key
        let item = removeValue(forKey: key)
        
        // 3、插入到新的数组中
        var index = hash(key) % capacity
        while let k = table[index], k.key != key, !k.deleted {
            index = (index + 1) % capacity
        }
        table[index] = Element(key, value, false)
        size += 1
        
        // 4、将旧数组中的第一个有效数据，搬运到新的数组中
        if let oTable = oldTable {
            while row < oTable.count {
                if let item = oTable[row], !item.deleted {
                    break
                }
                row += 1
            }
            
            if row < oTable.count {
                if let item = oTable[row] {
                    // 老数组删除
                    oldTable?[row]?.deleted = true
                    size -= 1
                    // 在新数组插入
                    insertValue(item.val, forKey: item.key)
                }
                row += 1
            } else {
                // 5、搬运完，把老数组删除
                oldTable = nil
                row = 0
            }
        }
        
        return item
    }
    
    // Hash函数
    private func hash(_ key: Key) -> Int {
        return abs(key.hashValue)
    }
    
    @discardableResult private func insertValue(_ value: Value, forKey key: Key) -> Value? {
        var index = hash(key) % capacity
        while let k = table[index], k.key != key {
            index = (index + 1) % capacity
        }
        if let k = table[index] {
            table[index] = Element(key, value, false)
            return k.val
        } else {
            table[index] = Element(key, value, false)
            size += 1
            return nil
        }
    }
}

extension LineHashTable: CustomStringConvertible {
    
    public var description: String {
        var str = "{\n"
        if let t = oldTable {
            for i in 0..<t.count {
                if let item = t[i], item.deleted == false {
                    str += "    " + String(describing: item.key) + " = " + String(describing: item.val) + ";\n"
                }
            }
        }
        for i in 0..<table.count {
            if let item = table[i], item.deleted == false {
                str += "    " + String(describing: item.key) + " = " + String(describing: item.val) + ";\n"
            }
        }
        str += "}"
        return str
    }
    
    public var debugDescription: String {
        var str = ""
        if let t = oldTable {
            for i in 0..<t.count {
                if let item = t[i] {
                    str += "old_table[\(i)]: " + String(describing: item.key) + " = " + String(describing: item.val) + " \(item.deleted)" + "\n"
                } else {
                    str += "old_table[\(i)]: " + "\n"
                }
            }
        }
        for i in 0..<table.count {
            if let item = table[i] {
                str += "table[\(i)]: " + String(describing: item.key) + " = " + String(describing: item.val) + " \(item.deleted)" + "\n"
            } else {
                str += "table[\(i)]: " + "\n"
            }
        }
        return str
    }
}




/**
  ----------------- ”链式法“ 解决Hash冲突  -----------------
 */
class HashTable<Key: Hashable, Value> {
    
    private typealias Element = (key: Key, val: Value)
    private typealias Bucket = [Element]
    private var buckets: [Bucket]
    private var oldBuckets: [Bucket]?
    
    private var capacity: Int
    private var factor: Float
    private var row: Int = 0
    
    public var size: Int = 0
    
    public var isEmpty: Bool { return size == 0 }
    
    init(_ capacity: Int, _ factor: Float) {
        self.capacity = capacity
        self.factor = factor
        self.buckets = [Bucket](repeating: [], count: capacity)
    }
    
    public subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
        set {
            if let value = newValue {
                updateValue(value, forKey: key)
            } else {
                removeValue(forKey: key)
            }
        }
    }
    
    public func value(forKey key: Key) -> Value? {
        // 1、优先去旧 HashTable 中查找
        if let oBuckets = oldBuckets {
            let index = hash(key) % oBuckets.count
            for element in oBuckets[index] {
                if element.key == key {
                    return element.val
                }
            }
        }
        
        let index = hash(key) % capacity
        for element in buckets[index] {
            if element.key == key {
                return element.val
            }
        }
        
        return nil
    }
    
    @discardableResult public func removeValue(forKey key: Key) -> Value? {
        // 1、优先删除 HashTable 中的数据
        if var oBuckets = oldBuckets {
            let index = hash(key) % oBuckets.count
            for (i, element) in oBuckets[index].enumerated() {
                if element.key == key {
                    oldBuckets![index].remove(at: i)
                    size -= 1
                    return element.val
                }
            }
        }
        
        let index = hash(key) % capacity
        for (i, element) in buckets[index].enumerated() {
            if element.key == key {
                buckets[index].remove(at: i)
                size -= 1
                return element.val
            }
        }
        
        return nil
    }
    
    @discardableResult public func updateValue(_ value: Value, forKey key: Key) -> Value? {
        // 1、扩容，直接把数据插入到新数组中
        let n: Int = Int(Float(capacity) * factor)
        if size >= n {
            capacity = 2 * capacity
            oldBuckets = buckets
            buckets = [Bucket](repeating: [], count: capacity)
        }

        // 2、将 HashTable 中的数据一条一条的搬
        if var oBuckets = oldBuckets {
            while row < oBuckets.count {
                if oBuckets[row].count > 0 {
                    let element = oBuckets[row][0]
                    oldBuckets![row].remove(at: 0)
                    size -= 1
                    setValue(element.val, forKey: element.key)
                    break
                }
                row += 1
            }
            if row >= oBuckets.count {
                oldBuckets = nil
                row = 0
            }
        }
        
        // 3、插入新数据
        return setValue(value, forKey: key)
    }
    
    @discardableResult private func setValue(_ value: Value, forKey key: Key) -> Value? {
        let index = hash(key) % capacity
        
        for (i, element) in buckets[index].enumerated() {
            if element.key == key {
                let oldValue = buckets[index][i].val
                buckets[index][i].val = value
                return oldValue
            }
        }
        
        buckets[index].append((key: key, val: value))
        size += 1
        return nil
    }
    
    
    // Hash函数
    private func hash(_ key: Key) -> Int {
        return abs(key.hashValue)
    }
}

extension HashTable: CustomStringConvertible {
    
    public var description: String {
        var str = ""
        if let oBuckets = oldBuckets {
            let pairs = oBuckets.flatMap{ b in b.map{ e in "\(e.key) = \(e.val)"} }
            str += pairs.joined(separator: ", ") + ", "
        }
        let pairs = buckets.flatMap{ b in b.map{ e in "\(e.key) = \(e.val)"} }
        str += pairs.joined(separator: ", ")
        return str
    }
    
    public var debugDescription: String {
        var str = ""
        if let oBuckets = oldBuckets {
            for (i, element) in oBuckets.enumerated() {
                let pairs = element.map { e in "\(e.key) = \(e.val)" }
                str += "old_bucket[\(i)]: " + pairs.joined(separator: ", ") + "\n"
            }
        }
        for (i, element) in buckets.enumerated() {
            let pairs = element.map { e in "\(e.key) = \(e.val)" }
            str += "bucket[\(i)]: " + pairs.joined(separator: ", ") + "\n"
        }
        return str
    }
}


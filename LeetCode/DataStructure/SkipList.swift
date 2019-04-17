//
//  SkipList.swift
//  LeetCode
//
//  Created by 许龙 on 2018/12/6.
//  Copyright © 2018 longxdragon. All rights reserved.
//

import Foundation

class SkipNode<T: Comparable> {
    var val: T?
    var maxLevel: Int = 0
    var forwards: Array = [SkipNode<T>?](repeating: nil, count: 16)
    
    init() {}
    
    init(val: T) {
        self.val = val
    }
}

/**
 ******* 跳表 *******
 
 空间换时间，通过多级的索引来提高查询速度，类似“二分查找”
 是一种动态的数据结构
 插入、查找、删除的时间复杂度都是 O(logn)
 空间复杂度是 O(n)
 */
class SkipList<T: Comparable> {
    let max = 16
    var levelCount = 1
    var head = SkipNode<T>()
    
    /**
     1、从最高索引开始遍历，遍历出每层索引比指定值小的节点
     2、判断下个节点是否等于指定值，等于即找到了，反之没有找到
     */
    public func find(_ val: T) -> SkipNode<T>? {
        var p = head
        
        for i in stride(from: levelCount-1, through: 0, by: -1) {
            while let n = p.forwards[i], n.val! < val {
                p = n
            }
        }
        
        if let n = p.forwards[0], n.val == val {
            return n
        } else {
            return nil
        }
    }
    
    /**
     1、随机生成要插入哪几个索引层
     2、updates存储每层索引，最后一个比指定值小的节点，即找到了插入节点的位置
     3、把newNode节点插入每一层索引的对应位置
     4、更新最大索引的计数
     */
    public func insert(_ val: T) {
        let level = randomLevel()
        let newNode: SkipNode = SkipNode(val: val)
        newNode.maxLevel = level
        
        // 新建一个数组
        var updates: Array = [SkipNode<T>?](repeating: nil, count: level)
        for i in 0..<level {
            updates[i] = head
        }
        
        var p = head
        for i in stride(from: level-1, through: 0, by: -1) {
            while let n = p.forwards[i], n.val! < val {
                p = n
            }
            updates[i] = p
        }
        
        for i in 0..<level {
            newNode.forwards[i] = updates[i]?.forwards[i]
            updates[i]?.forwards[i] = newNode
        }
        
        if levelCount < level {
            levelCount = level
        }
    }
    
    /**
     1、从最高索引开始遍历，遍历出每层索引比指定值小的节点
     2、在保证下个节点等于指定值的情况下，删除每层索引的下个节点
     */
    public func delete(_ val: T) {
        var updates: Array = [SkipNode<T>?](repeating: nil, count: levelCount)
        var p = head
        for i in stride(from: levelCount-1, through: 0, by: -1) {
            while let n = p.forwards[i], n.val! < val {
                p = n
            }
            updates[i] = p
        }
        
        if let n = p.forwards[0], n.val! == val {
            for i in stride(from: levelCount-1, through: 0, by: -1) {
                if let m = updates[i]?.forwards[i], m.val == val {
                    updates[i]?.forwards[i] = updates[i]?.forwards[i]?.forwards[i]
                }
            }
        }
    }
    
    public func printAll() {
        var p = head
        while let n = p.forwards[0] {
            for _ in 0..<n.maxLevel {
                print("\(n.val!) ", terminator: "")
            }
            print("")
            p = n
        }
        print("")
    }
    
    /**
     每层是否添加索引的概率都是50%，模拟返回需要添加索引的层数
     */
    private func randomLevel() -> Int {
        var level = 1
        for _ in 0..<max {
            if arc4random()%2 == 1 {
                level += 1
            }
        }
        return level
    }
}

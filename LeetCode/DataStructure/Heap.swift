//
//  Heap.swift
//  LeetCode
//
//  Created by 许龙 on 2019/1/28.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 堆：又可以叫“优先级队列-PriorityQueue”，按优先级出队列
 
 定义：
 1、完全二叉树
 2、任意节点都大于等于（或小于等于）左右子节点 “大于等于-大顶堆”，“小于等于-小顶堆”
 
 常规操作：
 1、插入（入队）
 2、取出堆顶（优先级最大的出队列）
 */
class Heap {
    
    public var datas: [Int]
    public var count: Int = 0
    
    private var capacity: Int
    // 大顶堆、小顶堆
    private var big: Bool
    
    init(_ capacity: Int, _ big: Bool) {
        self.capacity = capacity
        self.big = big
        // 下标从1开始
        self.datas = [Int](repeating: 0, count: capacity + 1)
    }
    
    /**
     删除并返回堆顶元素
     */
    @discardableResult func removeMax() -> Int {
        // 堆中无数据
        if count == 0 {
            return -1
        }
        // 1、把最后一个节点放到堆顶
        let val = datas[1]
        datas[1] = datas[count]
        count -= 1
        // 2、堆化
        heapify(&datas, count, 1)
        
        return val
    }
    
    /**
     插入元素
     */
    func insert(_ val: Int) {
        if count >= capacity {
            return
        }
        // 1、把数据添加到最后节点
        count += 1
        datas[count] = val
        // 2、自下向上堆化
        var i = count
        while i/2 > 0, (big ? datas[i/2] < datas[i] : datas[i/2] > datas[i]) {
            swap(&datas, i/2, i)
            i = i/2
        }
    }
    
    // 自上往下堆化
    func heapify(_ datas: inout Array<Int>, _ n: Int, _ i: Int) {
        var index = i
        while true {
            // 最大堆：比较当前节点、左节点、右节点哪个最大，把大的放在堆顶
            // 最小堆：比较当前节点、左节点、右节点哪个最大，把小的放在堆顶
            var max = index
            if index*2 <= n, (big ? datas[index] < datas[index*2] : datas[index] > datas[index*2]) {
                max = index*2
            }
            if index*2+1 <= n, (big ? datas[max] < datas[index*2+1] : datas[max] > datas[index*2+1]) {
                max = index*2+1
            }
            if max == index {
                break
            }
            swap(&datas, index, max)
            index = max
        }
    }
    
    /**
     替换堆顶元素
     */
    func replaceMax(_ val: Int) {
        if count == 0 {
            return
        }
        datas[1] = val
        heapify(&datas, count, 1)
    }
    
    /**
     获取堆顶元素
     */
    var maxValue: Int? {
        if count == 0 {
            return nil
        }
        return datas[1]
    }
    
    func swap(_ datas: inout Array<Int>, _ s: Int, _ e: Int) {
        let tmp = datas[s]
        datas[s] = datas[e]
        datas[e] = tmp
    }
    
    func printAll() {
        for i in 0...count {
            print("\(datas[i]) ", terminator: "")
        }
        print("")
    }
    
}

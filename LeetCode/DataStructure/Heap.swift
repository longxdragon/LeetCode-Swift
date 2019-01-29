//
//  Heap.swift
//  LeetCode
//
//  Created by 许龙 on 2019/1/28.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

class Heap {
    
    private var datas: [Int]
    private var capacity: Int
    private var count: Int = 0
    
    init(_ capacity: Int) {
        self.capacity = capacity
        // 下标从1开始
        self.datas = [Int](repeating: 0, count: capacity+1)
    }
    
    /**
     自下向上堆化，建堆
     */
    func buildHeapUp(_ datas: Array<Int>) {
        for i in 0..<datas.count {
            insert(datas[i])
        }
    }
    
    /**
     插入排序：n 表示数据的个数，数组 a 中的数据从下标 1 到 n 的位置
     
     desc:
     1、自上向下堆化，建堆
     2、把堆顶的数据跟最后的交换，然后剔除最后的数据，重新自上向下堆化
     
     最好：O(nlogn)
     最坏：O(nlogn)
     平均：O(nlogn)
     
     原地排序算法
     */
    func sort(_ datas: inout Array<Int>, _ n: Int) {
        buildHeapDown(&datas, n)
        var k = n
        while k >= 1 {
            swap(&datas, 1, k)
            k -= 1
            heapify(&datas, k, 1)
        }
    }
    
    /**
     自上向下堆化，建堆
     */
    func buildHeapDown(_ datas: inout Array<Int>, _ n: Int) {
        for i in stride(from: n/2, through: 1, by: -1) {
            heapify(&datas, n, i)
        }
    }
    
    func insert(_ val: Int) {
        if count >= capacity {
            return
        }
        // 1、把数据添加到最后节点
        count += 1
        datas[count] = val
        // 2、自下向上堆化
        var i = count
        while i/2 > 0, datas[i/2] < datas[i] {
            swap(&datas, i/2, i)
            i = i/2
        }
    }
    
    func removeMax() {
        // 堆中无数据
        if count == 0 {
            return
        }
        // 1、把最后一个节点放到堆顶
        datas[1] = datas[count]
        count -= 1
        // 2、堆化
        heapify(&datas, count, 1)
    }
    
    // 自上往下堆化
    func heapify(_ datas: inout Array<Int>, _ n: Int, _ i: Int) {
        var index = i
        while true {
            // 比较当前节点、左节点、右节点哪个更大，把大的放在堆顶
            var max = index
            if index*2 <= n, datas[index] < datas[index*2] {
                max = index*2
            }
            if index*2+1 <= n, datas[max] < datas[index*2+1] {
                max = index*2+1
            }
            if max == index {
                break
            }
            swap(&datas, index, max)
            index = max
        }
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

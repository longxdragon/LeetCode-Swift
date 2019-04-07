//
//  HeapSort.swift
//  LeetCode
//
//  Created by 许龙 on 2019/3/23.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

class HeapSort {
    /**
     堆排序
     
     desc:
     1、自上向下堆化，建大顶堆
     2、把堆顶的数据跟最后的交换，然后剔除最后的数据，重新自上向下堆化
     
     最好：O(nlogn)
     最坏：O(nlogn)
     平均：O(nlogn)
     
     原地排序算法，非稳定算法
     */
    public func heapSort(_ datas: inout Array<Int>) {
        // n 表示数据的个数，数组 a 中的数据从下标 0 到 n-1 的位置
        let index = datas.count - 1
        buildHeapDown(&datas, index)
        
        // 堆化的时间复杂度 O(n)，执行了 n 次，时间复杂度就是 O(nlogn)
        var k = index
        while k >= 0 {
            swap(&datas, 0, k)
            k -= 1
            heapify(&datas, k, 0)
        }
    }
    
    /**
     自上向下堆化，建大顶堆
     
     Note:
     从 (index-1)/2 开始到 0，进行堆化操作，因为从 (index-1)/2+1 开始往后 就是叶子节点了
     (index-1)/2 是 index 的父节点位置
     
     时间复杂度 O(n)
     */
    private func buildHeapDown(_ datas: inout Array<Int>, _ index: Int) {
        for i in stride(from: (index-1)/2, through: 0, by: -1) {
            heapify(&datas, index, i)
        }
    }
    
    private func heapify(_ datas: inout Array<Int>, _ n: Int, _ i: Int) {
        var index = i
        while true {
            // 比较当前节点、左节点、右节点哪个更大，把大的放在堆顶
            // 下标是从 0 开始的，所以左节点=i*2+1，右节点=i*2+2
            var max = index
            let l = index * 2 + 1
            let r = index * 2 + 2
            if l <= n, datas[index] < datas[l] {
                max = l
            }
            if r <= n, datas[max] < datas[r] {
                max = r
            }
            if max == index {
                break
            }
            swap(&datas, index, max)
            index = max
        }
    }
    
    private func swap(_ datas: inout Array<Int>, _ s: Int, _ e: Int) {
        let tmp = datas[s]
        datas[s] = datas[e]
        datas[e] = tmp
    }
}

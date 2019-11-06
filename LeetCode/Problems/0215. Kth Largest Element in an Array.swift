//
//  0215. Kth Largest Element in an Array.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/23.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 215. 数组中的第K个最大元素
 https://leetcode-cn.com/problems/kth-largest-element-in-an-array/
 
 时间复杂度：O(N)
 空间复杂度：O(1)
 */
extension Solution {
    /**
     解法1：小顶堆 O(N*logK)
     解法2：快排 O(N)
     */
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var arr = nums;
        if arr.count < k {
            return 0;
        }
        return partition(&arr, k, 0, arr.count - 1);
    }
    
    // 快速排序中的 partition
    private func partition(_ nums: inout [Int], _ k: Int, _ start: Int, _ end: Int) -> Int {
        let pivot = Int.random(in: start...end);
        swap(&nums, pivot, end);
        
        var i = start;
        for j in i..<end {
            if nums[j] > nums[end] { // 注意：大的放前面
                swap(&nums, i, j);
                i += 1;
            }
        }
        swap(&nums, i, end);
        
        if i + 1 == k {
            return nums[i];
        } else if i + 1 < k {
            return partition(&nums, k, i + 1, end);
        } else {
            return partition(&nums, k, start, i - 1);
        }
    }
    
    private func swap(_ nums: inout [Int], _ s: Int, _ e: Int) {
        let t = nums[s];
        nums[s] = nums[e];
        nums[e] = t;
    }
    
    /** 解法1：小顶堆解法 */
    private func findKthLargestWithHeap(_ nums: [Int], _ k: Int) -> Int {
        if nums.count < k {
            return 0;
        }
        // 1、建一个 n 大小的 小顶堆
        let heap = Heap(k, false);
        for i in 0..<k {
            heap.insert(nums[i]);
        }
        // 2、如果比堆顶还小，直接忽略，比堆顶大，就替换堆顶，然后重新堆化
        for i in k..<nums.count {
            if let max = heap.maxValue, max < nums[i] {
                heap.replaceMax(nums[i])
            }
        }
        return heap.maxValue!;
    }
}

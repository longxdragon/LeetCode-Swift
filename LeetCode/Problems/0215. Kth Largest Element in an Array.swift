//
//  0215. Kth Largest Element in an Array.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/23.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

// https://leetcode-cn.com/problems/kth-largest-element-in-an-array/
extension Solution {
    
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var arr = nums;
        if arr.count < k {
            return 0;
        }
        return partition(&arr, k, 0, arr.count - 1);
    }
    
    private func partition(_ nums: inout [Int], _ k: Int, _ start: Int, _ end: Int) -> Int {
        let pivot = Int.random(in: start...end);
        swap(&nums, pivot, end);
        
        var i = start;
        for j in i..<end {
            if nums[j] > nums[end] {
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
}

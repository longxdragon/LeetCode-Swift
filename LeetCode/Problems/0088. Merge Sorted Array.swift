//
//  0088.Merge Sorted Array.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/17.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 88. 合并两个有序数组
 https://leetcode-cn.com/problems/merge-sorted-array/
 
 时间复杂度：O(N)
 空间复杂度：O(1)
 */
extension Solution {
    
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        if n == 0 {
            return;
        }
        var p1 = m - 1;
        var p2 = n - 1;
        var p = m + n - 1;
        // 从后往前，在 nums1 里面直接操作，不需要额外空间
        while p1 >= 0 && p2 >= 0 {
            if nums1[p1] > nums2[p2] {
                nums1[p] = nums1[p1];
                p1 -= 1;
            } else {
                nums1[p] = nums2[p2];
                p2 -= 1;
            }
            p -= 1;
        }
        if p2 >= 0 {
            for i in 0...p2 {
                nums1[p] = nums2[i]
                p -= 1;
            }
        }
    }
}

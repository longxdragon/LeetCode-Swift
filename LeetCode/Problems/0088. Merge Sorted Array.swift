//
//  0088.Merge Sorted Array.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/17.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

// https://leetcode-cn.com/problems/merge-sorted-array/
extension Solution {
    
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        if n == 0 {
            return;
        }
        var p1 = m - 1;
        var p2 = n - 1;
        var p = m + n - 1;
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

//
//  0169.MajorityElement.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/14.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 169. 求众数
 https://leetcode-cn.com/problems/majority-element/
 
 时间复杂度：O(N)
 空间复杂度：O(1)
 */
extension Solution {
    // Boyer-Moore 投票算法
    func majorityElement(_ nums: [Int]) -> Int {
        var value = nums[0];
        var count = 1;
        for i in 1..<nums.count {
            if value == nums[i] {
                count += 1;
            } else {
                count -= 1;
                if count == 0 {
                    // the majority element always exist in the array.
                    // so will not out of range of array
                    value = nums[i+1];
                }
            }
        }
        return value;
    }
}

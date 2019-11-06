//
//  0001.SingleNumber.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/14.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 136. 只出现一次的数字
 https://leetcode-cn.com/problems/single-number/
 
 时间复杂度：O(N)
 空间复杂度：O(1)
 */
extension Solution {
    // 位运算
    func singleNumber(_ nums: [Int]) -> Int {
        if nums.count == 1 {
            return nums[0];
        }
        var result = nums[0];
        for i in 1..<nums.count {
            result ^= nums[i];
        }
        return result;
    }
}

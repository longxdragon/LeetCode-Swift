//
//  0268. Missing Number.swift
//  LeetCode
//
//  Created by 许龙 on 2019/11/6.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 268. 缺失数字
 https://leetcode-cn.com/problems/missing-number/
 
 时间复杂度：O(N)
 空间复杂度：O(1)
 */
extension Solution {
    
    // 位运算，下标 i 跟 val 异或
    func missingNumber(_ nums: [Int]) -> Int {
        var miss = nums.count;
        for i in 0..<nums.count {
            miss ^= nums[i] ^ i;
        }
        return miss;
    }
    
    // 数学方法：等差数列求和，n*(n+1)/2
    private func missingNumber_2(_ nums: [Int]) -> Int {
        var s = 0;
        for num in nums {
            s += num;
        }
        return nums.count * (nums.count + 1) / 2 - s;
    }
}

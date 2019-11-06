//
//  0137.SingleNumber2.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/14.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 137. 只出现一次的数字 II
 https://leetcode-cn.com/problems/single-number-ii/
 
 时间复杂度：O(N)
 空间复杂度：O(1)
 */
extension Solution {
    // 两个信号完成三个数位运算后为0
    func singleNumber2(_ nums: [Int]) -> Int {
        if nums.count == 1 {
            return nums[0];
        }
        var a = 0, b = 0;
        for num in nums {
            b = (b ^ num) & ~a;
            a = (a ^ num) & ~b;
        }
        return b;
    }
}

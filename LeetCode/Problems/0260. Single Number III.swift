//
//  0260.SingleNumber3.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/14.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 260. 只出现一次的数字 III
 https://leetcode-cn.com/problems/single-number-iii/
 
 时间复杂度：O(N)
 空间复杂度：O(1)
 */
extension Solution {
    
    // 两个数位运算后的拆解
    func singleNumber3(_ nums: [Int]) -> [Int] {
        if nums.count == 2 {
            return nums;
        }
        
        var result = 0;
        for num in nums {
            result ^= num;
        }
        
        // 找出两个数二进制最右位的不同，即 result 最右边为1
        result = result & (-result);
        
        var num1 = 0, num2 = 0;
        for num in nums {
            if num & result == 0 {
                num1 ^= num;
            } else {
                num2 ^= num;
            }
        }
        return [num1, num2];
    }
}

//
//  0260.SingleNumber3.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/14.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

// https://leetcode-cn.com/problems/single-number-iii/
extension Solution {
    
    func singleNumber3(_ nums: [Int]) -> [Int] {
        if nums.count == 2 {
            return nums;
        }
        
        var result = 0;
        for num in nums {
            result ^= num;
        }
        
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

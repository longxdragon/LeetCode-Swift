//
//  0001.SingleNumber.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/14.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

// https://leetcode-cn.com/problems/single-number/
extension Solution {
    
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

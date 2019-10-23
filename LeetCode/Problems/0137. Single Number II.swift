//
//  0137.SingleNumber2.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/14.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

// https://leetcode-cn.com/problems/single-number-ii/
extension Solution {
    
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

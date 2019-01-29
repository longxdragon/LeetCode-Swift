//
//  TwoSum.swift
//  LeetCode
//
//  Created by 许龙 on 2018/10/24.
//  Copyright © 2018 longxdragon. All rights reserved.
//

import Foundation

/**
 找出和等于目标数的两个数的下标
 https://leetcode-cn.com/problems/two-sum/description/
 */
class TwoSum {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var map = [Int: Int]();
        for (i, value) in nums.enumerated() {
            let left = target - value;
            if let n = map[left] {
                if n != i {
                    return [i, n];
                }
            }
            map[value] = i;
        }
        return [];
    }
}

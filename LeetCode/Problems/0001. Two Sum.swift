//
//  0001. Two Sum.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/30.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 1. 两数之和
 https://leetcode-cn.com/problems/two-sum/
 
 时间复杂度：O(N)
 空间复杂度：O(1)
 */
extension Solution {
    // HashMap
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var map = [Int: Int]();
        for (i, val) in nums.enumerated() {
            let left = target - val;
            if let j = map[left], j != i {
                return [j, i];
            }
            map[val] = i;
        }
        return [];
    }
}

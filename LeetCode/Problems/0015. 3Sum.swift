//
//  0015. 3Sum.swift
//  LeetCode
//
//  Created by 许龙 on 2019/11/5.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 15. 三数之和
 https://leetcode-cn.com/problems/3sum/
 */
extension Solution {
    
    func threeSum(_ nums: [Int]) -> [[Int]] {
        let len = nums.count;
        if len < 3 {
            return [];
        }
        let list = nums.sorted();
        var result = [[Int]]();
        for i in 0..<len {
            if list[i] > 0 {
                continue;  // 当前大于0，加上后面的肯定大于0，跳过
            }
            if i > 0 && list[i] == list[i - 1] {
                continue;  // 重复了，跳过
            }
            var left = i + 1;
            var right = len - 1;
            while left < right {
                let sum = list[i] + list[left] + list[right];
                if sum == 0 {
                    result.append([list[i], list[left], list[right]]);
                    // 跳过重复数据
                    while left < right && list[left] == list[left + 1] {
                        left += 1;
                    }
                    while left < right && list[right] == list[right - 1] {
                        right -= 1;
                    }
                    left += 1;
                    right -= 1;
                    continue;
                }
                if sum > 0 {
                    right -= 1;
                } else {
                    left += 1;
                }
            }
        }
        return result;
    }
}

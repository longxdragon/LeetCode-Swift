//
//  0229.MajorityElement.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/14.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 229. 求众数 II
 https://leetcode-cn.com/problems/majority-element-ii/
 
 时间复杂度：O(N)
 空间复杂度：O(1)
 */
extension Solution {
    
    func majorityElement(_ nums: [Int]) -> [Int] {
        if nums.count == 0 {
            return [];
        }
        // Boyer-Moore 投票算法 找出最大的两个值
        var c1 = 0, c2 = 0;
        var v1 = -1, v2 = -1;
        for num in nums {
            if (c1 == 0 || num == v1) && num != v2 {
                c1 += 1;
                v1 = num;
            } else if (c2 == 0 || num == v2) {
                c2 += 1;
                v2 = num;
            } else {
                c1 -= 1;
                c2 -= 1;
            }
        }
        // 累加看看是否超过 1/3
        c1 = 0;
        c2 = 0;
        for num in nums {
            if num == v1 {
                c1 += 1;
            }
            if num == v2 {
                c2 += 1;
            }
        }
        var result = [Int]();
        if c1 > nums.count/3 {
            result.append(v1);
        }
        if c2 > nums.count/3 {
            result.append(v2);
        }
        return result;
    }
}

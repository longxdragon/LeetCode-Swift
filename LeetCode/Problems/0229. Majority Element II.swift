//
//  0229.MajorityElement.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/14.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

// https://leetcode-cn.com/problems/majority-element-ii/
extension Solution {
    
    func majorityElement(_ nums: [Int]) -> [Int] {
        if nums.count == 0 {
            return [];
        }
        // find max count of values
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
        // check out of 1/3
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
        // v1 != v2
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

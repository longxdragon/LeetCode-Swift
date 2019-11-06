//
//  0448. Find All Numbers Disappeared in an Array.swift
//  LeetCode
//
//  Created by 许龙 on 2019/11/6.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 448. 找到所有数组中消失的数字
 https://leetcode-cn.com/problems/find-all-numbers-disappeared-in-an-array/
 
 时间复杂度：O(N)
 空间复杂度：O(1)
 */
extension Solution {
    
    func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        let len = nums.count;
        if len == 0 {
            return [];
        }
        // 负值代表存在，正数代表不存在
        var list = nums;
        for num in list {
            if num == len {
                list[0] = -abs(list[0]);
            } else {
                list[num] = -abs(list[num]);
            }
        }
        var rs = [Int]();
        for i in 1..<len {
            if list[i] > 0 {
                rs.append(i);
            }
        }
        if list[0] > 0 {
            rs.append(len);
        }
        return rs;
    }
}

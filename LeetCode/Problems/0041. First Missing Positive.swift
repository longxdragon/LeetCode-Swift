//
//  0041. First Missing Positive.swift
//  LeetCode
//
//  Created by 许龙 on 2019/11/6.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 41. 缺失的第一个正数
 https://leetcode-cn.com/problems/first-missing-positive/
 
 时间复杂度：O(N)
 空间复杂度：O(1)
 */
extension Solution {
    
    func firstMissingPositive(_ nums: [Int]) -> Int {
        let len = nums.count;
        var list = nums;
        // 1、不存在 1 的话，最小的正整数就是 1
        var count = 0;
        for i in 0..<len {
            if list[i] == 1 {
                count += 1;
            }
        }
        if count == 0 {
            return 1;
        }
        // 2、只有一个 1，最小的正整数就是 2
        if len == 1 && list[0] == 1 {
            return 2;
        }
        // 3、把负数或者大于 len 的数字改成 1，因为最小的正整数肯定不在里面
        for i in 0..<len {
            if list[i] <= 0 || list[i] > len {
                list[i] = 1;
            }
        }
        // 4、list[i] 代表 数字 i 是否存在，list[i] 正数就代表不存在，负数就代表存在
        for num in list {
            if num == len {
                list[0] = -abs(list[0]);
            } else {
                list[num] = -abs(list[num]);
            }
        }
        // 5、优先从下标 1 开始
        for i in 1..<len {
            if list[i] > 0 {
                return i;
            }
        }
        // 6、再判断是否有 == len 的整数值
        if list[0] > 0 {
            return len;
        }
        return len + 1;
    }
}

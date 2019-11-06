//
//  0287. Find the Duplicate Number.swift
//  LeetCode
//
//  Created by 许龙 on 2019/11/6.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 287. 寻找重复数
 https://leetcode-cn.com/problems/find-the-duplicate-number/
 
 时间复杂度：O(N)
 空间复杂度：O(1)
 */
extension Solution {
    
    /* 链表有环的解法：快慢指针 */
    func findDuplicate(_ nums: [Int]) -> Int {
        var tor = nums[0];
        var har = nums[nums[0]];
        while tor != har {
            tor = nums[tor];
            har = nums[nums[har]];
        }
        tor = 0;
        while tor != har {
            tor = nums[tor];
            har = nums[har];
        }
        return tor;
    }
    
    /* 通用方法：二分查找 O(N*logN) */
    private func findDuplicate_2(_ nums: [Int]) -> Int {
        var left = 1;
        var right = nums.count;
        while left < right {
            let mid = left + (right - left)/2;
            var count = 0;
            for num in nums {
                if num <= mid {
                    count += 1;
                }
            }
            if count > mid {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }
}

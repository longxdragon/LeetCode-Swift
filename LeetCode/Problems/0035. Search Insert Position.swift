//
//  0035. Search Insert Position.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/23.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 35. 搜索插入位置
 https://leetcode-cn.com/problems/search-insert-position/
 
 时间复杂度：O(logN)
 空间复杂度：O(1)
 */
extension Solution {
    // 二分查找
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var left = 0, right = nums.count - 1;
        while left <= right {
            let mid = left + (right - left)/2;
            if target < nums[mid] {
                right = mid - 1;
            } else if target > nums[mid] {
                left = mid + 1;
            } else {
                return mid;
            }
        }
        return left;
    }
}

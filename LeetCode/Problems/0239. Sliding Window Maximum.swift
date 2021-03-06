//
//  0239. Sliding Window Maximum.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/18.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 239. 滑动窗口最大值
 https://leetcode-cn.com/problems/sliding-window-maximum/
 
 时间复杂度：O(N)
 空间复杂度：O(N)
 */
extension Solution {
    
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        if nums.count * k == 0 {
            return [];
        }
        if k == 1 {
            return nums;
        }
        var result = [Int]();
        var deque = [Int]();
        for i in 0..<nums.count {
            while deque.count > 0 && nums[deque.last!] < nums[i] {
                deque.removeLast();   // 总共只会执行 N 次
            }
            deque.append(i);
            
            if i >= k - 1 {
                if deque[0] <= i - k {
                    deque.removeFirst();
                }
                result.append(nums[deque[0]]);
            }
        }
        return result;
    }
}

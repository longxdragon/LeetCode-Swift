//
//  0409. Longest Palindrome.swift
//  LeetCode
//
//  Created by 许龙 on 2019/11/1.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 409. 最长回文串
 https://leetcode-cn.com/problems/longest-palindrome/
 */
extension Solution {
    
    func longestPalindrome(_ s: String) -> Int {
        var map = [Character: Int]();
        // 标记出不一样字符的个数
        var flag = 0;
        for chr in Array(s) {
            let val = map[chr] ?? 0;
            if val == 1 {
                map[chr] = 0;
                flag -= 1;
            } else {
                map[chr] = 1;
                flag += 1;
            }
        }
        if flag <= 1 {
            return s.count;
        }
        return s.count - flag + 1;
    }
}

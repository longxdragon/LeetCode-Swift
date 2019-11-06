//
//  0132. Palindrome Partitioning II.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/21.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

// https://leetcode-cn.com/problems/palindrome-partitioning-ii/
extension Solution {
    
    func minCut(_ s: String) -> Int {
        if s.count <= 1 {
            return 0;
        }
        let chars = Array(s);
        /**
         状态转移公式，
         1、dp[i][j]标记从 s[i] 到 s[j] 是否是回文字符；
         2、d[i] 代表 从 s[i] 到结尾最小分割次数；
            假设在 “i~n” 之间 j 的位置来一刀，dp[i][j] 是回文字符，那么 d[i] = min(d[i], 1 + d[j+1]);
            j 如果等于 n-1，代表不需要切，dp[i][n-1] 是整个回文字符，d[i] = 0;
         */
        var dp = [[Bool]](repeating: [Bool](repeating: false, count: chars.count), count: chars.count);
        var d = [Int](repeating: Int.max, count: chars.count);
        for i in stride(from: chars.count-1, through: 0, by: -1) {
            for j in i..<chars.count {
                let len = j - i + 1;
                if chars[i] == chars[j] && (len < 3 || dp[i+1][j-1]) {
                    dp[i][j] = true;
                    if j < chars.count - 1 {
                        d[i] = min(d[i], 1 + d[j+1]);
                    } else {
                        d[i] = 0;
                    }
                }
            }
        }
        return d[0];
    }
}

//
//  0005. Longest Palindromic Substring.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/22.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 5. 最长回文子串
 https://leetcode-cn.com/problems/longest-palindromic-substring/
 
 时间复杂度：O(N*N)
 空间复杂度：O(N*N)
 */
extension Solution {
    
    func longestPalindrome(_ s: String) -> String {
        if s.count <= 1 {
            return s;
        }
        /**
         dp[i][j] 子串 s[i]-s[j] 是否是回文字符；
         那么：
         dp[i][i] = true;                         j-i = 0;   len = 1;
         dp[i][i+1] = s[i] == s[i+1];             j-i = 1;   len = 2;
         dp[i][j] = dp[i+1][j-1] && s[i] == s[j];  j-i >= 2;  len >= 3;
         
         转换下：
         len = 1 或者 len = 2；直接比较 s[i] == s[j] 即可
         len >= 3；dp[i][j] = dp[i+1][j-1] && s[i] == s[j];
        */
        let chars = Array(s);
        var si = 0, ei = 0;
        var dp = [[Bool]](repeating: [Bool](repeating: false, count: s.count), count: s.count);
        for i in stride(from: chars.count-1, through: 0, by: -1) {
            for j in i..<chars.count {
                let len = j - i + 1;
                dp[i][j] = chars[i] == chars[j] && (len < 3 || dp[i+1][j-1]);
                // 判断最长子串
                if dp[i][j] && j - i >= ei - si {
                    si = i;
                    ei = j;
                }
            }
        }
        return String(chars[si...ei]);
    }
}

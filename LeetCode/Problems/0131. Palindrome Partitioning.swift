//
//  0131. Palindrome Partitioning.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/21.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

// https://leetcode-cn.com/problems/palindrome-partitioning/
extension Solution {
    
    func partition(_ s: String) -> [[String]] {
        let chars = Array(s);
        // 状态转移公式
        var dp = [[Bool]](repeating: [Bool](repeating: false, count: s.count), count: s.count);
        for i in stride(from: chars.count-1, through: 0, by: -1) {
            for j in i..<chars.count {
                let len = j - i + 1;
                dp[i][j] = chars[i] == chars[j] && (len < 3 || dp[i+1][j-1]);
            }
        }
        
        var result = [[String]]();
        var sub = [String]();
        tracePartition(chars, &result, &sub, 0, dp);
        return result;
    }
    
    /**
     分治：前面的回文字符 + 后面字符拆分的数组
     比如：aabb = a | abb = a + ["a","b","b"] + ["a","bb"] = ["a","a","b","b"] + ["a","a","bb"];
     大问题划分成子问题，然后子问题答案合并
    */
    private func dividePartition(_ s: [Character], _ start: Int, _ dp: [[Bool]]) -> [[String]] {
        if start == s.count {
            return [[String]](repeating: [String](), count: 1);
        }
        var result = [[String]]();
        for i in start..<s.count {
            let sub = String(s[start...i]);
            if dp[start][i] {
                for var tmp in dividePartition(s, i+1, dp) {
                    tmp.insert(sub, at: 0);
                    result.append(tmp);
                }
            }
        }
        return result;
    }
    
    /**
     回溯：先一个一个拆分，是回文字符就加入到数组中；拆到最后然后回溯，考虑最后两个字符是否是回文字符，依次回溯最后三个字符。。。
     比如：aabb = 四次dfs后 = ["a","a","b","b"]，然后回溯考虑"bb" = ["a","a","bb"]
     再次回溯考虑"abb" = ["a","a",""]
     */
    private func tracePartition(_ s: [Character],
                                _ result: inout [[String]],
                                _ sub: inout [String],
                                _ start: Int,
                                _ dp: [[Bool]]) {
        if start == s.count {
            result.append(sub);
        }
        for i in start..<s.count {
            let str = String(s[start...i]);
            if dp[start][i] {
                sub.append(str);
                tracePartition(s, &result, &sub, i+1, dp);
                sub.removeLast();
            }
        }
    }
}

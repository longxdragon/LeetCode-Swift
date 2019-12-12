//
//  0051. N-Queens.swift
//  LeetCode
//
//  Created by 许龙 on 2019/11/10.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 51. N皇后
 https://leetcode-cn.com/problems/n-queens/
 */
extension Solution {
    
    func solveNQueens(_ n: Int) -> [[String]] {
        var dp = [Int](repeating: -1, count: n);
        var rs = [[String]]();
        solveQueens(0, n, &dp, &rs);
        return rs;
    }
    
    private func solveQueens(_ row: Int, _ n: Int, _ dp: inout [Int], _ rs: inout [[String]]) {
        if row == n {
            rs.append(formatSolve(dp, n));
            return;
        }
        for col in 0..<n {
            if isOk(row, col, n, &dp) {
                dp[row] = col;
                solveQueens(row + 1, n, &dp, &rs);  // 这边没有回退操作，因为都是从“0-row”比较
            }
        }
    }
    
    private func isOk(_ row: Int, _ col: Int, _ n: Int, _ dp: inout [Int]) -> Bool {
        var left = col - 1, right = col + 1;
        for i in stride(from: row - 1, through: 0, by: -1) {
            if dp[i] == col {  // 同一列存在
                return false;
            }
            if left >= 0 && dp[i] == left {  // 左上对角线存在
                return false;
            }
            if right < n && dp[i] == right {  // 右上对角线存在
                return false;
            }
            left -= 1;
            right += 1;
        }
        return true;
    }
    
    private func formatSolve(_ dp: [Int], _ n: Int) -> [String] {
        var rs = [String]();
        for row in 0..<n {
            var str = "";
            for col in 0..<n {
                if dp[row] == col {
                    str.append("Q");
                } else {
                    str.append(".");
                }
            }
            rs.append(str);
        }
        return rs;
    }
}

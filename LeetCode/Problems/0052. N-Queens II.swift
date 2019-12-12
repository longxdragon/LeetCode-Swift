//
//  0052. N-Queens II.swift
//  LeetCode
//
//  Created by 许龙 on 2019/11/10.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 52. N皇后 II
 https://leetcode-cn.com/problems/n-queens-ii/
 */
extension Solution {
    
    func totalNQueens(_ n: Int) -> Int {
        var dp = [Int](repeating: -1, count: n);
        var total = 0;
        solveQueens(0, n, &dp, &total);
        return total;
    }
    
    private func solveQueens(_ row: Int, _ n: Int, _ dp: inout [Int], _ total: inout Int) {
        if row == n {
            total += 1;
            return;
        }
        for col in 0..<n {
            if isOk(row, col, n, dp) {
                dp[row] = col;
                solveQueens(row + 1, n, &dp, &total);
            }
        }
    }
    
    private func isOk(_ row: Int, _ col: Int, _ n: Int, _ dp: [Int]) -> Bool {
        var leftUp = col - 1, rightUp = col + 1;
        for i in stride(from: row - 1, through: 0, by: -1) {
            if dp[i] == col {
                return false;
            }
            if leftUp >= 0 && dp[i] == leftUp {
                return false;
            }
            if rightUp < n && dp[i] == rightUp {
                return false;
            }
            leftUp -= 1;
            rightUp += 1;
        }
        return true;
    }
}

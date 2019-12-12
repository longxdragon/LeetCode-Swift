//
//  1222. Queens That Can Attack the King.swift
//  LeetCode
//
//  Created by 许龙 on 2019/11/10.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 1222. 可以攻击国王的皇后
 https://leetcode-cn.com/problems/queens-that-can-attack-the-king/
 */
extension Solution {
    
    func queensAttacktheKing(_ queens: [[Int]], _ king: [Int]) -> [[Int]] {
        var dp = [[Int]](repeating: [Int](repeating: 0, count: 8), count: 8);
        for i in 0..<queens.count {
            dp[queens[i][0]][queens[i][1]] = 1;
        }
        // 8个方向依次遍历
        let dirctions = [[-1, 0], [-1, 1], [-1, -1], [1, 0], [1, 1], [1, -1], [0, 1], [0, -1]];
        var rt = [[Int]]();
        for dir in dirctions {
            var x = king[0] + dir[0];
            var y = king[1] + dir[1];
            while x >= 0 && x < 8 && y >= 0 && y < 8 {
                if dp[x][y] == 1 {
                    rt.append([x, y]);
                    break;
                }
                x += dir[0];
                y += dir[1];
            }
        }
        return rt;
    }
}

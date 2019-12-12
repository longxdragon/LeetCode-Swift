//
//  1001. Grid Illumination.swift
//  LeetCode
//
//  Created by 许龙 on 2019/11/10.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 1001. 网格照明
 https://leetcode-cn.com/problems/grid-illumination/
 */
extension Solution {
    
    func gridIllumination(_ N: Int, _ lamps: [[Int]], _ queries: [[Int]]) -> [Int] {
        var row_dp = [Int](repeating: 0, count: N);     // 哪一行被点亮
        var column_dp = [Int](repeating: 0, count: N);  // 哪一列被点亮
        var left_dp = [Int](repeating: 0, count: 2*N);  // 左上->右下被点亮
        var right_dp = [Int](repeating: 0, count: 2*N - 1); // 左上->右上被点亮
        
        var lamp_map = [Int: Int]();    // 记录亮灯的位置
        for l in lamps {
            let n = l[0];
            let m = l[1];
            row_dp[n] += 1
            column_dp[m] += 1;
            right_dp[n + m] += 1;
            left_dp[n - m + N] += 1;
            
            let k = n * N + m;
            lamp_map[k] = 1;
        }
        
        var rt = [Int]();
        let dirctions = [[-1, 0], [-1, 1], [-1, -1], [1, 0], [1, 1], [1, -1], [0, 1], [0, -1]];
        for list in queries {
            let n = list[0];
            let m = list[1];
            if right_dp[n + m] > 0 || left_dp[n - m + N] > 0 || row_dp[n] > 0 || column_dp[m] > 0 {
                rt.append(1);
            } else {
                rt.append(0);
            }
            for dir in dirctions {
                let x = n + dir[0];
                let y = m + dir[1];
                let k = x * N + y;
                if let _ = lamp_map[k] {
                    row_dp[x] -= 1;
                    column_dp[y] -= 1;
                    right_dp[x + y] -= 1;
                    left_dp[x - y + N] -= 1;
                    lamp_map.removeValue(forKey: k);
                }
            }
        }
        return rt;
    }
}

//
//  MinCoin.swift
//  LeetCode
//
//  Created by 许龙 on 2019/3/13.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

class MinCoin {
    
    public var min = Int.max
    
    // 递归实现
    func minCoinCountWithRollBack(_ values: Array<Int>, _ i: Int, _ amount: Int, _ w: Int) {
        if w > amount {
            return
        }
        if w == amount {
            min = i < min ? i : min;
            return
        }
        for k in 0..<values.count {
            minCoinCountWithRollBack(values, i + 1, amount, w + values[k]);
        }
    }
    
    // 动态规划
    func minCoinCountWithDynamicProgramming(_ values: Array<Int>, _ amount: Int) {
        var states = [[Bool]]();
        
        states.append([Bool](repeating: false, count: amount+1))
        for k in 0..<values.count {
            states[0][values[k]] = true
        }
        
        for i in 1..<amount+1 {
            states.append([Bool](repeating: false, count: amount+1))
            for j in 1..<amount+1 {
                if states[i-1][j] {
                    for k in 0..<values.count {
                        if j + values[k] <= amount {
                            states[i][j + values[k]] = true
                            if states[i][amount] {
                                self.min = i + 1
                                return
                            }
                        }
                    }
                }
            }
        }
    }
    
    // 求最长递增子序列长度
    func findLong(_ datas: Array<Int>) -> Int {
        if datas.count <= 1 {
            return 0
        }
        var lss = [Int](repeating: 1, count: datas.count)
        for i in 1..<datas.count {
            var max = lss[i-1]
            for j in 0..<i {
                if datas[j] < datas[i] && lss[j] > max-1 {
                    max = lss[j] + 1
                }
            }
            lss[i] = max
        }
        return lss[datas.count-1]
    }
    
}

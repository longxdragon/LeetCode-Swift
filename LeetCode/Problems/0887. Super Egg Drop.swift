//
//  0887.Super Egg Drop.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/17.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 887. 鸡蛋掉落
 https://leetcode-cn.com/problems/super-egg-drop/
 https://www.jianshu.com/p/2f06a3eb953c
 
 时间复杂度：O(K*logN)
 空间复杂度：O(K)
 */
extension Solution {
    /**
     转换成问题：K个鸡蛋，M次移动，最大可以确定多少层
     
     dp[0][m] = 0
     dp[k][0] = 0
     dp[1][m] = m (m > 0)
     dp[k][m] = dp[k-1][m-1] + dp[k][m-1] + 1 (k > 0, m>0)
     
     这边为什么是 dp[k][m-1] + dp[k-1][m-1] + 1 ?
     假设第一次，在 X 层扔下鸡蛋，结果鸡蛋碎了，可以往下验证 dp[k-1][m-1](k-1个鸡蛋，m-1步) 层数。
     如果鸡蛋没碎，可以往上验证 dp[k][m-1] 层数
     */
    func superEggDrop(_ K: Int, _ N: Int) -> Int {
        var dp = [Int](repeating: 0, count: K+1);
        var m = 0;
        while dp[K] < N {
            m += 1;
            for k in stride(from: K, to: 0, by: -1) {
                dp[k] += dp[k-1] + 1;
            }
        }
        return m;
    }
}

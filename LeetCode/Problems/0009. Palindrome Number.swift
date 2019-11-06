//
//  0009. Palindrome Number.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/30.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 9. 回文数
 https://leetcode-cn.com/problems/palindrome-number/
 */
extension Solution {
    // 正反数比较
    func isPalindrome(_ x: Int) -> Bool {
        guard x > 0 else {
            return x == 0;
        }
        var y = 0;
        var val = x;
        while val > 0 {
            y *= 10;
            y += val % 10;
            val /= 10;
        }
        return x == y;
    }
}

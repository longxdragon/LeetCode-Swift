//
//  PalindromeNumber.swift
//  LeetCode
//
//  Created by 许龙 on 2018/10/24.
//  Copyright © 2018 longxdragon. All rights reserved.
//

import Foundation

/**
 判断是否是回文数
 https://leetcode-cn.com/problems/palindrome-number/description/
 */
class PalindromeNumber {
    func isPalindrome(_ x: Int) -> Bool {
        var val = x
        if val < 0 {
            return false
        }
        
        var arr = [Int]()
        var i: Int = -1
        while val > 0 {
            arr.insert(val % 10, at: 0)
            val = val / 10
            i += 1
        }
        
        var j: Int = 0
        var ye: Bool = true
        while i >= j {
            if arr[i] != arr[j] {
                ye = false
                break
            }
            i -= 1
            j += 1
        }
        return ye
    }
}

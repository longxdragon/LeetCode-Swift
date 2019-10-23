//
//  0680. Valid Palindrome II.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/18.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

// https://leetcode-cn.com/problems/valid-palindrome-ii/
extension Solution {
    
    func validPalindrome(_ s: String) -> Bool {
        let chars: [Character] = Array(s);
        return isPalindrom(chars, 0, chars.count - 1, 1);
    }
    
    private func isPalindrom(_ chars: [Character], _ left: Int, _ right: Int, _ errNum: Int) -> Bool {
        var l = left;
        var r = right;
        while l < r {
            if chars[l] == chars[r] {
                l += 1;
                r -= 1;
            } else if errNum > 0 {
                return isPalindrom(chars, l+1, r, errNum-1) || isPalindrom(chars, l, r-1, errNum-1);
            } else {
                return false;
            }
        }
        return true;
    }
}

//
//  0125. Valid Palindrome.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/18.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 125. 验证回文串
 https://leetcode-cn.com/problems/valid-palindrome/
 
 时间复杂度：O(N)
 空间复杂度：O(1)
 */
extension Solution {
    
    func isPalindrome(_ s: String) -> Bool {
        let chars = s.lowercased().utf8CString;
        var l = 0;
        var r = chars.count - 1;
        while l < r {
            if !isValildCharacter(chars[l]) {
                l += 1;
                continue;
            }
            if !isValildCharacter(chars[r]) {
                r -= 1;
                continue;
            }
            if chars[l] == chars[r] {
                l += 1;
                r -= 1;
            } else {
                return false;
            }
        }
        return true;
    }
    
    func isValildCharacter(_ chr: CChar) -> Bool {
        return (chr >= 97 && chr <= 122) || (chr >= 48 && chr <= 57);
    }
}

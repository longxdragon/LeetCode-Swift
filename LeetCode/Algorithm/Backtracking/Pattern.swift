//
//  Pattern.swift
//  LeetCode
//
//  Created by 许龙 on 2019/4/17.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 -------------- 正则表达式匹配 --------------
 */
class Pattern {
    
    var pattern: [Character]
    var plen: Int
    private var matched: Bool
    
    init(_ pattern: [Character], _ plen: Int) {
        self.pattern = pattern
        self.plen = plen
        self.matched = false
    }
    
    func match(_ text: [Character], _ tlen: Int) -> Bool {
        matched = false
        rmatch(0, 0, text, tlen)
        return matched
    }
    
    func rmatch(_ ti: Int, _ pj: Int, _ text: [Character], _ tlen: Int) {
        if pj == plen {
            if ti == tlen {
                matched = true
            }
            return
        }
        
        if ti < tlen, pattern[pj] == text[ti] {
            // 完全匹配
            rmatch(ti+1, pj+1, text, tlen)
            
        } else if pattern[pj] == "*" {
            // 匹配任意个字符
            for k in 0...tlen-plen+1 {
                rmatch(ti+k, pj+1, text, tlen)
            }
        } else if pattern[pj] == "?" {
            // 匹配 0 个或者 1 个字符
            rmatch(ti, pj+1, text, tlen)
            rmatch(ti+1, pj+1, text, tlen)
        }
    }
    
}

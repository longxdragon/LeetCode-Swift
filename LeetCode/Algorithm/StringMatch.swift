//
//  StringMatch.swift
//  LeetCode
//
//  Created by 许龙 on 2019/2/1.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 字符串匹配算法
 */
class StringMatch {
    /**
     ------------------- Brute Force 暴力匹配算法 -------------------
     */
    func matchBF(_ s: Array<Character>, _ p: Array<Character>) -> Int {
        let n = s.count
        let m = p.count
        if m > n {
            return -1
        }
        // 依次往后匹配，匹配不合适，就往后移一位，继续重新比较
        var i = 0
        var j = 0
        while i < n, j < m {
            if s[i] == p[j] {
                i += 1
                j += 1
            } else {
                i = i - j + 1
                j = 0
            }
        }
        
        if j == m {
            return i - j
        } else {
            return -1
        }
    }
    
    /**
     ------------------- Rabin-Karp 算法 -------------------
     */
    func matchRK(_ s: Array<Character>, _ p: Array<Character>) -> Int {
        let n = s.count
        let m = p.count
        if m > n {
            return -1
        }
        // 计算每个子字符串的 Hash 值
        var hashValues = [Int]()
        var val = 0
        for i in 0..<n {
            val += s[i].toInt()
            if i >= m-1 {
                hashValues.append(val)
                val -= s[i-m+1].toInt()
            }
        }
        
        let subHashVal = hashValue(p)
        for (i, val) in hashValues.enumerated() {
            if val == subHashVal {
                // 防止 Hash 冲突，还需要比对一次
                for j in 0..<m-1 {
                    let c1 = s[i+j]
                    let c2 = p[j]
                    if c1 != c2 {
                        return -1
                    }
                }
                return i
            }
        }
        
        return -1
    }
    
    private func hashValue(_ string: Array<Character>) -> Int {
        var val = 0
        for i in 0..<string.count {
            val += string[i].toInt()
        }
        return val
    }
    
    /**
     ------------------- Boyer-Moore 算法 -------------------
     */
    func matchBM(_ string: Array<Character>, _ subString: Array<Character>) -> Int {
        let n = string.count
        let m = subString.count
        if m > n {
            return -1
        }
        // 记录每个字符最后出现的位置
        var bc = [Character: Int]()
        generateBC(subString, &bc)
        // 算出 后缀子串的长度 -> 模式串中能匹配后缀子串的子串的初始位置
        var suffix = [Int: Int]()
        generateGS(subString, &suffix)
        
        var i = 0
        while i <= n-m {
            var si = -1 // 代表坏字符的位置
            for j in stride(from: m-1, through: 0, by: -1) {
                if subString[j] != string[i+j] {
                    si = j
                    break
                }
            }
            // 匹配成功
            if si < 0 {
                return i
            }
            
            // 1、计算坏符号规则，需要后移的位数
            let bad = string[i+si]
            var xi = -1
            if let c = bc[bad] {
                xi = c
            }
            let x = si - xi
            
            // 2、计算好后缀规则，需要后移的位数
            var y = 0
            if si < m-1 {
                y = moveByGS(si, m, suffix)
            }
            
            i += max(x, y)
        }
        
        return -1
    }
    // bc[c] = i；c 代表字符，i 代表字符在模式串中的最后的下标
    private func generateBC(_ string: Array<Character>, _ bc: inout [Character: Int]) {
        for (i, c) in string.enumerated() {
            bc[c] = i
        }
    }
    // suffix[k] = j； k 代表后缀子串的长度，j 代表模块串的子串与后缀子串匹配的开始下标
    private func generateGS(_ string: Array<Character>, _ suffix: inout [Int: Int]) {
        let m = string.count
        for i in 0..<m-1 {
            var j = i
            var k = 1
            while j >= 0, string[j] == string[m-k] {
                suffix[k] = j
                j -= 1
                k += 1
            }
        }
    }
    /**
     根据 suffix 算出需要后移的位数
     */
    private func moveByGS(_ si: Int, _ m: Int, _ suffix: [Int: Int]) -> Int {
        // 好后缀的长度
        let length = m - 1 - si
        if let x = suffix[length] {
            // 好后缀，在模式串中有匹配的子串，模式串往后移，跟好后缀对应上
            return si - x + 1
        }
        for i in stride(from: length-1, through: 0, by: -1) {
            // 找到好后缀的最长子串与前缀子串匹配，后移 m-i 位
            if let x = suffix[i], x == 0 {
                return m - i
            }
        }
        // 都不满足，后移 m 位
        return m
    }
    
    /**
     ------------------- KMP 算法 -------------------
     */
    func matchKMP(_ s: Array<Character>, _ p: Array<Character>) -> Int {
        let n = s.count
        let m = p.count
        if m > n {
            return -1
        }
        
        var next = getNext(p)
        var j = 0
        for i in 0..<n {
            // 匹配错误，好前缀规则；j = 0，i 往后移，直接比较下一个
            while j > 0 && s[i] != p[j] {
                j = next[j-1] + 1
            }
            // 匹配正确
            if s[i] == p[j] {
                j += 1
            }
            if j == m {
                return j - m + 1
            }
        }
        return -1
    }
    
    func getNext(_ p: Array<Character>) -> [Int] {
        var next = [Int](repeating: -1, count: p.count)
        var k = -1
        for j in 1..<p.count {
            while k > 0 && p[k+1] != p[j] {
                k = next[k]
            }
            if p[k+1] == p[j] {
                k += 1
            }
            next[j] = k
        }
        return next
    }
    
}


extension Character {
    
    func toInt() -> Int {
        var val = 0
        for scalar in self.unicodeScalars {
            val = Int(scalar.value)
        }
        return val
    }
}

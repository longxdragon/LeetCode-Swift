//
//  Recursion.swift
//  LeetCode
//
//  Created by 许龙 on 2018/10/30.
//  Copyright © 2018 longxdragon. All rights reserved.
//

import Foundation

class Recursion {
    var dic: Dictionary = [Int: Int]()
    
    // 大量的递归操作，会造成函数、变量不断的压栈，就会造成 stackoverflow(栈溢出) 的问题
    func walkStep(num: Int) -> Int {
        if num == 1 {
            return 1
        }
        if num == 2 {
            return 2
        }
        
        // 解决重复计算的问题
        if let n = dic[num] {
            return n
        }
        
        let n = walkStep(num:num-1) + walkStep(num:num-2)
        dic[num] = n
        
        return n
    }
    
    // 所有的递归都可以改成非递归的写法
    // 虽然解决了 stackoverflow 的问题，但是空间复杂度依然还是 O(n)
    func walkStepWithoutStackOverFlow(num: Int) -> Int {
        if num == 1 {
            return 1
        }
        if num == 2 {
            return 2
        }
        
        var ret = 0
        var pre1 = 1
        var pre2 = 2
        for _ in 3...num {
            ret = pre1 + pre2
            pre1 = pre2
            pre2 = ret
        }
        return ret
    }
}

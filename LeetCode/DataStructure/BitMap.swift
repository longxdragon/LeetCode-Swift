//
//  BitMap.swift
//  LeetCode
//
//  Created by 许龙 on 2019/4/7.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 -------- 位图 --------
 
 引申：“布隆过滤器” -- 大小固定，利用多个Hash函数，修改对应不同的下标的值，取的时候，如果多个下标的值有不是true，就代表不存在
 问题：
 1、存在Hash冲突，返回是true，但是有可能并不存在
 2、依然需要考虑“扩容”问题
 */
class BitMap {
    var bytes: [UInt8]
    var nbits: Int
    
    init(_ nbits: Int) {
        self.nbits = nbits
        self.bytes = [UInt8](repeating: 0, count: nbits/8+1)
    }
    
    func set(_ k: Int) {
        if k > nbits {
            return
        }
        let byteIndex = k/8
        let bitIndex = k%8
        self.bytes[byteIndex] = self.bytes[byteIndex] | (1 << bitIndex)
    }
    
    func get(_ k: Int) -> Bool {
        if k > nbits {
            return false
        }
        let byteIndex = k/8
        let bitIndex = k%8
        return (self.bytes[byteIndex] & (1 << bitIndex)) != 0
    }
    
}

/**
 -------- 贝叶斯算法 --------
 
 公式：P(A/B) = P(B/A) * P(A) / P(B)
 
 应用场景：
 1、“垃圾短信”过滤
 2、“垃圾邮件”过滤
 
 方案：
 1、基于黑名单的过滤器
 2、基于规则的过滤器
 3、基于贝叶斯算法的过滤器
 4、机器学习？？？
 */

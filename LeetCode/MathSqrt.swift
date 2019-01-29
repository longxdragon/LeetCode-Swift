//
//  MathSqrt.swift
//  LeetCode
//
//  Created by 许龙 on 2018/12/4.
//  Copyright © 2018 longxdragon. All rights reserved.
//

import Foundation

class MathSqrt {
    // 求一个数的平方根
    func sqrt(_ val: Double, _ percision: Double) -> Double {
        if val < 0 {
            return Double.nan
        }
        
        var low: Double = 0.0
        var high: Double = val
        if val < 1 {
            low = val
            high = 1.0
        }
        
        var mid = low + (high - low)/2
        while high - low > percision {
            if mid * mid > val {
                high = mid
            } else if mid * mid < val {
                low = mid
            } else {
                return mid
            }
            mid = low + (high - low)/2
        }
        return mid
    }
}

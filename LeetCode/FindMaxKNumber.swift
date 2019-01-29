//
//  FindMaxKNumber.swift
//  LeetCode
//
//  Created by 许龙 on 2018/11/21.
//  Copyright © 2018 longxdragon. All rights reserved.
//

import Foundation

/**
 O(n)复杂度找出无序数组中第K大的数字
 
 Note:
 每次查找只需要查一半，N+N/2+N/4+N/8+N/16....+1 = (N-1/2*1)/(1-1/2) = 2N-1
 时间复杂度为 O(n)
 */
class FindMaxKNumber {
    func find(_ items: inout Array<Int>, _ k: Int) -> Int {
        if items.count < k {
            return 0
        }
        return partition(&items, 0, items.count - 1, k)
    }
    
    func partition(_ items: inout Array<Int>, _ start: Int, _ end: Int, _ k: Int) -> Int {
        let val = items[end]
        var i = start
        for j in i..<end {
            if items[j] > val {
                let tmp = items[i]
                items[i] = items[j]
                items[j] = tmp
                i += 1
            }
        }
        items[end] = items[i]
        items[i] = val
        
        if i + 1 == k {
            return items[i]
        } else if i + 1 < k {
            return partition(&items, i + 1, end, k)
        } else {
            return partition(&items, start, i - 1, k)
        }
    }
}

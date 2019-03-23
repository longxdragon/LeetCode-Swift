//
//  Permutations.swift
//  LeetCode
//
//  Created by 许龙 on 2019/1/28.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 输出数组的全排列
 Input: [1,2,3]
 Output: [ [1,2,3], [1,3,2], [2,1,3], [2,3,1], [3,1,2], [3,2,1] ]
 */
class Permutations {
    
    func printPermutations(_ data: inout Array<Int>, _ begin: Int, _ end: Int) {
        if begin == end {
            printAllDatas(data, end)
        } else {
            for i in begin...end {
                // 防止重复数据
                if !isSwap(data, begin, i) {
                    continue
                }
                
                var tmp = data[begin]
                data[begin] = data[i]
                data[i] = tmp
                
                printPermutations(&data, begin+1, end)
                
                tmp = data[begin]
                data[begin] = data[i]
                data[i] = tmp
            }
        }
    }
    
    func printAllDatas(_ data: Array<Int>, _ end: Int) {
        for i in 0...end {
            print("\(data[i]) ", terminator: "")
        }
        print("")
    }
    
    func isSwap(_ data: Array<Int>, _ begin: Int, _ end: Int) -> Bool {
        for i in begin..<end {
            if data[i] == data[end] {
                print("------ ", terminator: "")
                printAllDatas(data, end)
                return false
            }
        }
        return true
    }
}

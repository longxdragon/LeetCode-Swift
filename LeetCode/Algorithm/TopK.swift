//
//  TopK.swift
//  LeetCode
//
//  Created by 许龙 on 2019/1/29.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

class TopK {
    /**
     时间复杂度：O(nlogn)
     */
    func findTopK(_ datas: Array<Int>, _ n: Int) -> Array<Int> {
        if n <= 0 {
            return []
        }
        if datas.count <= n {
            return datas
        }
        
        // 1、建一个 n 大小的 小顶堆
        let heap = Heap(n, false)
        for i in 0..<n {
            heap.insert(datas[i])
        }
        // 2、如果比堆顶还小，直接忽略，比堆顶大，就替换堆顶，然后重新堆化
        for i in n..<datas.count {
            if let max = heap.maxValue, max < datas[i] {
                heap.replaceMax(datas[i])
            }
        }
        
        var rt = heap.datas
        rt.removeFirst()
        return rt
    }
}

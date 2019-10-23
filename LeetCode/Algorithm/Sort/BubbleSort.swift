//
//  BubbleSort.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/23.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

class BubbleSort {
    
    /**
     冒泡排序

     desc:
     两两比较，一次冒泡，找出最大的放到最后，依次类推

     最好：O(n)
     最坏：O(n^2)
     平均：O(n^2)
     
     原地排序、稳定算法
     */
    func bubbleSort(_ items: inout [Int]) {
        if items.count <= 1 {
            return;
        }
        for i in 0..<items.count {
            var flag = false;
            for j in 0..<items.count-i-1 {
                if items[j] > items[j+1] {
                    let t = items[j];
                    items[j] = items[j+1];
                    items[j+1] = t;
                    flag = true;
                }
            }
            if flag == false {
                return;
            }
        }
    }
}

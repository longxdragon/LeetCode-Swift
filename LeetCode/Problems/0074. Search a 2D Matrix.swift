//
//  0074.Search a 2D Matrix.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/16.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 74. 搜索二维矩阵
 https://leetcode-cn.com/problems/search-a-2d-matrix/
 
 时间复杂度：O(logM+logN)
 空间复杂度：O(1)
 */
extension Solution {
    
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        if matrix.count == 0 || matrix[0].count == 0 {
            return false;
        }
        // Binary search to find the last one smaller than the target
        var s = 0;
        var e = matrix.count - 1;
        var row = e;
        while s <= e {
            let mid = s + (e - s)/2;
            if matrix[mid][0] > target {
                e = mid - 1;
            } else {
                if mid == matrix.count - 1 || matrix[mid+1][0] > target {
                    row = mid;
                    break;
                } else {
                    s = mid + 1;
                }
            }
        }
        // Simple binary search
        s = 0;
        e = matrix[row].count - 1;
        while s <= e {
            let mid = s + (e - s)/2;
            if target > matrix[row][mid] {
                s = mid + 1;
            } else if target < matrix[row][mid] {
                e = mid - 1;
            } else {
                return true;
            }
        }
        return false;
    }
}

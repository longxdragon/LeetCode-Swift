//
//  0240.Search a 2D Matrix II.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/17.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 240. 搜索二维矩阵 II
 https://leetcode-cn.com/problems/search-a-2d-matrix-ii/
 
 时间复杂度：O(N)
 空间复杂度：O(1)
 */
extension Solution {
    
    func searchMatrixII(_ matrix: [[Int]], _ target: Int) -> Bool {
        if matrix.count == 0 {
            return false;
        }
        // 从右上角开始筛选
        var row = 0;
        var col = matrix[0].count - 1;
        while row < matrix.count && col >= 0 {
            if target < matrix[row][col] {
                col -= 1;
            } else if target > matrix[row][col] {
                row += 1;
            } else {
                return true;
            }
        }
        return false;
    }
}

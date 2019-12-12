//
//  0122. Best Time to Buy and Sell Stock II.swift
//  LeetCode
//
//  Created by 许龙 on 2019/11/28.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 122. 买卖股票的最佳时机 II
 https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-ii/
 */
extension Solution {
    
    func maxProfit(_ prices: [Int]) -> Int {
        if prices.count <= 1 {
            return 0;
        }
        var profit = 0;
        var price = prices[0];
        for i in 1..<prices.count {
            if prices[i] > price {
                profit += prices[i] - price;
            }
            price = prices[i];
        }
        return profit;
    }
}

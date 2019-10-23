//
//  0862.Shortest Subarray with Sum at Least K.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/17.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

// https://leetcode-cn.com/problems/shortest-subarray-with-sum-at-least-k/
extension Solution {
    
    func shortestSubarray(_ A: [Int], _ K: Int) -> Int {
        var preSum = [Int](repeating: 0, count: A.count + 1);
        for i in 0..<A.count {
            preSum[i+1] = preSum[i] + A[i];
        }
        let deque = Deque<Int>();
        var min = A.count + 1;
        for i in 0...A.count {
            while let last = deque.peekBack(), preSum[i] <= preSum[last] {
                deque.dequeueBack();
            }
            while let first = deque.peekFront(), preSum[i] - preSum[first] >= K {
                deque.dequeue();
                if i - first < min {
                    min = i - first;
                }
            }
            deque.enqueue(i);
        }
        return (min == A.count + 1) ? -1 : min;
    }
}

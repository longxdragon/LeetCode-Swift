//
//  LCTestSort.swift
//  LeetCodeTests
//
//  Created by 许龙 on 2019/3/23.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import XCTest
@testable import LeetCode

class LCSortTests: XCTestCase {
    
    func testTopoSort() {
        // ”图“里面存的是下标值，如果要存对象的话，可以用额外的数组储存
        let graph: Graph = Graph(4)
        graph.addEdgeForward(1, 2)
        graph.addEdgeForward(1, 0)
        graph.addEdgeForward(2, 0)
        graph.addEdgeForward(2, 3)
        
        let sort = TopoSort()
        sort.topoSortByKahn(graph);
        sort.topoSortByDFS(graph)
    }
}

//
//  GraphTest.swift
//  LeetCodeTests
//
//  Created by 许龙 on 2019/4/3.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import XCTest
@testable import LeetCode

class GraphTest: XCTestCase {
    
    func testShortestPath() {
//        let graph = PathGraph(6)
//        graph.addEdge(0, 1, 10)
//        graph.addEdge(0, 4, 15)
//        graph.addEdge(1, 2, 15)
//        graph.addEdge(1, 3, 2)
//        graph.addEdge(2, 5, 5)
//        graph.addEdge(3, 2, 1)
//        graph.addEdge(3, 5, 12)
//        graph.addEdge(4, 5, 10)
        
        
        let graph = PathGraph(15)
        graph.addEdge(1, 3, 1)
        graph.addEdge(2, 3, 1)
        graph.addEdge(3, 2, 1)
        graph.addEdge(3, 5, 1)
        graph.addEdge(4, 6, 1)
        graph.addEdge(5, 3, 1)
        graph.addEdge(5, 7, 1)
        graph.addEdge(6, 4, 1)
        graph.addEdge(6, 9, 1)
        graph.addEdge(7, 5, 1)
        graph.addEdge(7, 8, 1)
        graph.addEdge(8, 7, 1)
        graph.addEdge(8, 9, 1)
        graph.addEdge(8, 10, 1)
        graph.addEdge(9, 6, 1)
        graph.addEdge(9, 8, 1)
        graph.addEdge(10, 8, 1)
        graph.addEdge(10, 11, 1)
        graph.addEdge(11, 10, 1)
        graph.addEdge(11, 12, 1)
        graph.addEdge(11, 14, 1)
        graph.addEdge(12, 11, 1)
        graph.addEdge(12, 13, 1)
        
        graph.dijkstra(1, 13)
    }
    
    func testAstarPath() {
        let graph = PathGraph(15)
        graph.addEdge(1, 3, 1)
        graph.addEdge(2, 3, 1)
        graph.addEdge(3, 2, 1)
        graph.addEdge(3, 5, 1)
        graph.addEdge(4, 6, 1)
        graph.addEdge(5, 3, 1)
        graph.addEdge(5, 7, 1)
        graph.addEdge(6, 4, 1)
        graph.addEdge(6, 9, 1)
        graph.addEdge(7, 5, 1)
        graph.addEdge(7, 8, 1)
        graph.addEdge(8, 7, 1)
        graph.addEdge(8, 9, 1)
        graph.addEdge(8, 10, 1)
        graph.addEdge(9, 6, 1)
        graph.addEdge(9, 8, 1)
        graph.addEdge(10, 8, 1)
        graph.addEdge(10, 11, 1)
        graph.addEdge(11, 10, 1)
        graph.addEdge(11, 12, 1)
        graph.addEdge(11, 14, 1)
        graph.addEdge(12, 11, 1)
        graph.addEdge(12, 13, 1)
        
        graph.addVextex(1, 2, 0)
        graph.addVextex(2, 1, 1)
        graph.addVextex(3, 2, 1)
        graph.addVextex(4, 4, 1)
        graph.addVextex(5, 2, 2)
        graph.addVextex(6, 4, 2)
        graph.addVextex(7, 2, 3)
        graph.addVextex(8, 3, 3)
        graph.addVextex(9, 4, 3)
        graph.addVextex(10, 3, 4)
        graph.addVextex(11, 3, 5)
        graph.addVextex(12, 4, 5)
        graph.addVextex(13, 5, 5)
        graph.addVextex(14, 3, 6)
        
        graph.astar(1, 13)
    }
}

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
        let graph = PathGraph(6)
        graph.addEdge(0, 1, 10)
        graph.addEdge(0, 4, 15)
        graph.addEdge(1, 2, 15)
        graph.addEdge(1, 3, 2)
        graph.addEdge(2, 5, 5)
        graph.addEdge(3, 2, 1)
        graph.addEdge(3, 5, 12)
        graph.addEdge(4, 5, 10)
        
        graph.dijkstra(0, 5)
    }
}

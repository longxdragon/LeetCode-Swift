//
//  TopoSort.swift
//  LeetCode
//
//  Created by 许龙 on 2019/3/23.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 拓扑排序 -> 依赖于“有向图”处理
 */
class TopoSort {
    /**
     Kahn 算法
     */
    public func topoSortByKahn(_ graph: Graph) {
        // 统计每个顶点的入度
        let v = graph.v
        var inDegree = [Int](repeating: 0, count: v)
        for i in 0..<v {
            for j in 0..<graph.adj[i].size {
                if let w = graph.adj[i].getValue(j) {
                    inDegree[w] += 1;
                }
            }
        }
        
        let queue = LinkedQueue<Int>()
        for i in 0..<v {
            if inDegree[i] == 0 {
                queue.enqueue(i);
            }
        }
        // 入度为 0 的，优先输出
        while let i = queue.dequeue() {
            print(" -> \(i)", terminator: "")
            // 并且把关联的顶点，入度 -1，依次循环
            for j in 0..<graph.adj[i].size {
                if let w = graph.adj[i].getValue(j) {
                    inDegree[w] -= 1
                    if inDegree[w] == 0 {
                        queue.enqueue(w)
                    }
                }
            }
        }
        print(" ")
    }
    
    /**
     DFS 深度优先算法
     */
    public func topoSortByDFS(_ graph: Graph) {
        let v = graph.v
        // 构建逆邻接表，s -> t，表示 t 先于 s
        var inverseAdj = [LinkedList<Int>](repeating: LinkedList<Int>(), count: v)
        for i in 0..<v {
            inverseAdj[i] = LinkedList<Int>()
        }
        // 通过邻接表，生成逆邻接表
        for i in 0..<v {
            for j in 0..<graph.adj[i].size {
                if let w = graph.adj[i].getValue(j) {
                    inverseAdj[w].add(i)
                }
            }
        }
        // 深度优先遍历图
        var visited = [Bool](repeating: false, count: v)
        for i in 0..<v {
            if !visited[i] {
                visited[i] = true;
                dfs(i, inverseAdj, &visited)
            }
        }
        print(" ")
    }
    
    public func dfs(_ vertex: Int, _ inverseAdj: [LinkedList<Int>], _ visited: inout [Bool]) {
        for i in 0..<inverseAdj[vertex].size {
            if let w = inverseAdj[vertex].getValue(i) {
                if visited[w] {
                    continue
                } else {
                    visited[w] = true
                    dfs(w, inverseAdj, &visited)
                }
            }
        }
        print(" -> \(vertex)", terminator: "")
    }
    
}

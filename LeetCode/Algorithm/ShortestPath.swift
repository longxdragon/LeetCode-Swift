//
//  ShortestPath.swift
//  LeetCode
//
//  Created by 许龙 on 2019/4/2.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

// 边
public class PathEdge {
    var sId: Int    // 开始节点
    var eId: Int    // 结束节点
    var w: Int      // 权重
    
    init(_ sId: Int, _ eId: Int, _ w: Int) {
        self.sId = sId
        self.eId = eId
        self.w = w
    }
}

// 顶点
public class PathVertex {
    var vId: Int    // 节点下标
    var dist: Int   // 从初始位置到当前节点的路径大小
    var f: Int
    var x: Int
    var y: Int
    
    init(_ vId: Int, _ x: Int, _ y: Int) {
        self.vId = vId
        self.x = x
        self.y = y
        self.dist = Int(INT_MAX)
        self.f = Int(INT_MAX)
    }
}

// 优先队列 - ”小顶堆“
private class PathPriorityQueue {
    var nodes: [PathVertex]
    var count: Int
    var capacity: Int
    
    init(_ count: Int) {
        self.count = 0
        self.capacity = count
        self.nodes = [PathVertex](repeating: PathVertex(0, 0, 0), count: count+1)
    }
    
    func poll() -> PathVertex? {
        if count == 0 {
            return nil
        }
        let vertex = nodes[1]
        nodes[1] = nodes[count]
        count -= 1
        
        heapifyDown(&nodes, 1)
        
        return vertex
    }
    
    func add(_ v: PathVertex) {
        if count >= capacity {
            return
        }
        count += 1
        nodes[count] = v
        
        heapifyUp(&nodes, count)        
    }
    
    func update(_ v: PathVertex) {
        var index = 1
        while index <= count {
            if nodes[index].vId == v.vId {
                break
            }
            index += 1
        }
        if index <= count {
            nodes[index] = v
        }
    }
    
    func clear() {
        count = 0
    }
    
    // 从下标s开始，自上往下堆化
    private func heapifyDown(_ datas: inout [PathVertex], _ s: Int) {
        var index = s;
        while true {
            var m = index
            if index*2 <= count, datas[index*2].dist < datas[m].dist {
                m = index*2
            }
            if index*2+1 <= count, datas[index*2+1].dist < datas[m].dist {
                m = index*2+1
            }
            if m == index {
                break;
            }
            // swap
            let t = datas[index]
            datas[index] = datas[m]
            datas[m] = t
            
            index = m
        }
    }
    // 从下标s开始，自下往上堆化
    private func heapifyUp(_ datas: inout [PathVertex], _ s: Int) {
        var index = s
        
        while index/2 > 0, datas[index/2].dist > datas[index].dist {
            let t = datas[index/2]
            datas[index/2] = datas[index]
            datas[index] = t
            
            index = index/2
        }
    }
}

public class PathGraph {
    var v: Int
    var adj: [LinkedList<PathEdge>]
    var vertexs: [PathVertex]
    
    init(_ v: Int) {
        self.v = v
        self.adj = [LinkedList<PathEdge>](repeating: LinkedList<PathEdge>(), count: v)
        for i in 0..<v {
            self.adj[i] = LinkedList<PathEdge>()
        }
        self.vertexs = [PathVertex](repeating: PathVertex(0, 0, 0), count: v)
    }
    
    func addEdge(_ s: Int, _ e: Int, _ w: Int) {
        self.adj[s].add(PathEdge(s, e, w))
    }
    
    func addVextex(_ vId: Int, _ x: Int, _ y: Int) {
        self.vertexs[vId] = PathVertex(vId, x, y)
    }
    
    /**
     ------------------- 最短路径问题 -------------------
     */
    func dijkstra(_ s: Int, _ e: Int) {
        var predecessor = [Int](repeating: 0, count: v)
        var inqueue = [Bool](repeating: false, count: v)
        let priorityQueue = PathPriorityQueue(v)
        
        var vertexs = [PathVertex](repeating: PathVertex(0, 0, 0), count: v)
        for i in 0..<v {
            vertexs[i] = PathVertex(i, 0, 0)
        }
        
        vertexs[s].dist = 0
        priorityQueue.add(vertexs[s])
        inqueue[s] = true
        
        while let vertex = priorityQueue.poll() {
            // 需要等到到 e 最短的距离出队列，才终止循环
            if vertex.vId == e {
                break
            }
            for i in 0..<self.adj[vertex.vId].size {
                let edge = self.adj[vertex.vId].node(at: i).val
                let nextVertex = vertexs[edge.eId]
                if vertex.dist + edge.w < nextVertex.dist {
                    nextVertex.dist = vertex.dist + edge.w
                    
                    if inqueue[nextVertex.vId] {
                        priorityQueue.update(nextVertex)
                    } else {
                        priorityQueue.add(nextVertex)
                        inqueue[nextVertex.vId] = true
                    }
                    predecessor[nextVertex.vId] = vertex.vId
                }
            }
        }
        
        printShortestPath(s, e, predecessor)
        print("")
    }
    
    func printShortestPath(_ s: Int, _ t: Int, _ predecessor: [Int]) {
        if s == t {
            print("\(t)", terminator: "")
            return
        }
        printShortestPath(s, predecessor[t], predecessor)
        print(" -> \(t)", terminator: "")
    }
    
    /**
     ------------------- A*算法 -------------------
     */
    func astar(_ s: Int, _ e: Int) {
        var predecessor = [Int](repeating: 0, count: v)
        var inqueue = [Bool](repeating: false, count: v)
        let priorityQueue = PathPriorityQueue(v)

        self.vertexs[s].dist = 0
        self.vertexs[s].f = 0
        priorityQueue.add(self.vertexs[s])
        inqueue[s] = true
        
        while let vertex = priorityQueue.poll() {
            for i in 0..<self.adj[vertex.vId].size {
                let edge = self.adj[vertex.vId].node(at: i).val
                let nextVertex = self.vertexs[edge.eId]
                
                // 这边的“f”就相当于之前的“dist”
                // 修改后的“dist” = f + 曼哈顿距离
                if vertex.f + edge.w < nextVertex.f {
                    nextVertex.f = vertex.f + edge.w
                    nextVertex.dist = nextVertex.f + manhattan(nextVertex, self.vertexs[e])
                    
                    if inqueue[nextVertex.vId] {
                        priorityQueue.update(nextVertex)
                    } else {
                        priorityQueue.add(nextVertex)
                        inqueue[nextVertex.vId] = true
                    }
                    predecessor[nextVertex.vId] = vertex.vId
                }
                
                // 只要可以走到 e 就直接返回，所以 A*算法，不是最短路径方案
                if nextVertex.vId == e {
                    // 清空优先队列，才能退出 while 循环
                    priorityQueue.clear()
                    break
                }
            }
        }
        
        printShortestPath(s, e, predecessor)
        print("")
    }
    
    func manhattan(_ v1: PathVertex, _ v2: PathVertex) -> Int {
        return abs(v1.x - v2.x) + abs(v1.y - v2.y)
    }
}

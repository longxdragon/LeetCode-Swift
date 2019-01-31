//
//  Graph.swift
//  LeetCode
//
//  Created by 许龙 on 2019/1/30.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 图： 邻接表的实现
 */
class Graph {
    private var v: Int
    private var adj: [LinkedList<Int>]
    
    init(_ v: Int) {
        self.v = v
        self.adj = [LinkedList<Int>](repeating: LinkedList<Int>(), count: v)
        for i in 0..<v {
            self.adj[i] = LinkedList<Int>()
        }
    }
    
    /**
     无向图：添加 s->e e->s 都建立关系
     */
    func addEdge(_ s: Int, _ e: Int) {
        adj[s].add(Node(val: e))
        adj[e].add(Node(val: s))
    }
    
    /**
     有向图：添加 s->e 即可
     */
    func addEdgeForward(_ s: Int, _ e: Int) {
        adj[s].add(Node(val: e))
    }
    
    /** 查找节点的 N 度关系 */
    func findRelation(_ s: Int, _ n: Int) {
        if n == 0 {
            return
        }
        
        var visited: Array<Bool> = [Bool](repeating: false, count: v)
        visited[s] = true
        let queue = LinkedQueue<Int>()
        queue.enqueue(s)
        
        var list: Array<Array<Int>?> = Array()
        var levels: Array<Int> = Array()
        var last: Int? = s
        var level = n
        
        while queue.size > 0, level > 0 {
            if let val = queue.dequeue() {
                for i in 0..<adj[val].size {
                    if let p = adj[val].getValue(i) {
                        if visited[p] {
                            continue
                        }
                        visited[p] = true
                        queue.enqueue(p)
                        levels.append(p)
                    }
                }
                // 某一度的好友遍历完毕
                if let l = last, l == val {
                    list.append(levels)
                    last = levels.last
                    levels = Array()
                    level -= 1
                }
            }
        }
        print(list)
    }
    
    /**
     ----------------- 广度优先搜索：最短路径 -----------------
     
     时间复杂度 O(E) E=边的个数，实际每次搜索都需要遍历 V+E，E>=V-1
     空间复杂度 O(V) V=顶点的个数
     */
    func bfs(_ s: Int, _ e: Int) {
        // 开始、结束节点一样，就不需要遍历
        if s == e {
            return
        }
        // prev 中储存的是当前节点是从哪个节点遍历过来的
        var prev = [Int](repeating: -1, count: v)
        var visited: [Bool] = [Bool](repeating: false, count: v)
        visited[s] = true
        
        let queue = LinkedQueue<Int>()
        queue.enqueue(s)
        
        while queue.size > 0 {
            // val 为当前出队列的顶点
            if let val = queue.dequeue() {
                // 遍历当前顶点 val 的所有关联顶点
                for i in 0..<adj[val].size {
                    if let p = adj[val].getValue(i) {
                        // 之前已经遍历过了
                        if visited[p] {
                            continue
                        }
                        // 存储遍历的上一个顶点 val
                        prev[p] = val
                        // 找到了
                        if p == e {
                            printLoad(prev, s, e)
                            print("")
                            return
                        }
                        // 没找到，继续找
                        visited[p] = true
                        queue.enqueue(p)
                    }
                }
            }
        }
    }
    
    /**
     ----------------- 深度遍历优先搜索：回溯算法 -----------------
     
     时间复杂度 O(E) E=边的个数，每个边都会走两次，遍历一次，回溯一次，2E
     空间复杂度 O(V) V=顶点的个数
     */
    var found: Bool = false
    
    func dfs(_ s: Int, _ e: Int) {
        // 开始、结束节点一样，就不需要遍历
        if s == e {
            return
        }
        // prev 中储存的是当前节点是从哪个节点遍历过来的
        var prev = [Int](repeating: -1, count: v)
        var visited: [Bool] = [Bool](repeating: false, count: v)
        visited[s] = true
        found = false
        
        // 递归遍历
        recurDfs(s, e, &visited, &prev)
        printLoad(prev, s, e)
        print("")
    }
    
    func recurDfs(_ p: Int, _ e: Int, _ visited: inout Array<Bool>, _ prev: inout Array<Int>) {
        if found {
            return
        }
        visited[p] = true
        if p == e {
            found = true
            return
        }
        for i in 0..<adj[p].size {
            if let q = adj[p].getValue(i) {
                // 遍历过了，就跳过
                if visited[q] {
                    continue
                }
                prev[q] = p
                // 递归遍历
                recurDfs(q, e, &visited, &prev)
            }
        }
    }
    
    /**
     打印 s -> e 顶点的路径
     */
    func printLoad(_ prev: Array<Int>, _ s: Int, _ e: Int) {
        if prev[e] != -1, s != e {
            // 递归输出经过的路径
            printLoad(prev, s, prev[e])
        }
        print("\(e) ", terminator: "")
    }
}

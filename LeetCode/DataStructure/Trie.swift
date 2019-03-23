//
//  Trie.swift
//  LeetCode
//
//  Created by 许龙 on 2019/2/19.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

class TrieNode {
    var data: Character
    var child: [TrieNode?] = [TrieNode?](repeating: nil, count: 26)
    var isEndingChar = false
    
    init(_ data: Character) {
        self.data = data
    }
}

/**
 ------------------- Trip 树 - “字典树” -------------------
 Note:
 多叉树的实现方式
 此实现，只针对 a-z 26个字符做储存
 
 弊端：
 字符集比较多的情况下，child 数组比较大，比较耗内存
 
 优化：
 可以考虑用 散列表、红黑树、跳表 去存储 child
 
 使用场景：
 公共前缀的查找 比如：“搜索关键字提示”
 建Trie：O(kn)
 匹配：O(n)
 */
class Trie {
    // 存储无意义的字符
    private var root: TrieNode = TrieNode("/")
    
    /**
     插入到对应的位置处
     */
    public func insert(_ text: [Character]) {
        var p = root
        for i in 0..<text.count {
            let index = text[i].toInt() - 97
            if p.child[index] == nil {
                p.child[index] = TrieNode(text[i])
            }
            if let node = p.child[index] {
                p = node
            }
        }
        p.isEndingChar = true
    }
    
    /**
     查询 字符串text 是否在字符串集中
     */
    public func find(_ text: [Character]) -> Bool {
        var p = root
        for i in 0..<text.count {
            let index = text[i].toInt() - 97
            if let node = p.child[index], node.data == text[i] {
                p = node
            } else {
                return false
            }
        }
        // 不是完全匹配，text 只是某些字符串的前缀子串
        // 如果只是前缀匹配（搜索关键字提示）这边可以直接返回 true
        if !p.isEndingChar {
            return false
        }
        return true
    }
    
}


class AcTrieNode {
    var data: Character
    var child: [AcTrieNode?] = [AcTrieNode?](repeating: nil, count: 26)
    var isEndingChar = false
    var length = 0
    
    var failNode: AcTrieNode?
    
    init(_ data: Character) {
        self.data = data
    }
}
/**
 ------------------- AC自动机 -------------------
 Note:
 “AC自动机”相对于“Trie树”，就相当于 “KMP”算法相对于“BF”算法
 
 使用场景：
 适合大文本中多模式串的精确匹配查找 比如：“是否包含敏感词”
 建Trie：O(kn)
 匹配：O(n)
 */
class AcTrie {
    private var root: AcTrieNode = AcTrieNode("/")
    
    public func insert(_ text: [Character]) {
        var p = root
        for i in 0..<text.count {
            let index = text[i].toInt() - 97
            if p.child[index] == nil {
                p.child[index] = AcTrieNode(text[i])
            }
            if let node = p.child[index] {
                p = node
            }
        }
        p.isEndingChar = true
        p.length = text.count
    }
    
    public func find(_ text: [Character]) -> Bool {
        var p = root
        for i in 0..<text.count {
            let index = text[i].toInt() - 97
            if let node = p.child[index], node.data == text[i] {
                p = node
            } else {
                return false
            }
        }
        if !p.isEndingChar {
            return false
        }
        return true
    }
    
    public func buildFailurePointer() {
        let queue = LinkedQueue<AcTrieNode>()
        root.failNode = nil
        queue.enqueue(root)
        
        while let p = queue.dequeue() {
            // 遍历每个子节点
            for i in 0..<26 {
                /**
                 p.fail = q
                 p.child = pc
                 pc.fail = qc
                 */
                if let pc = p.child[i] {
                    if p === root {
                        pc.failNode = root
                    } else {
                        var fail = p.failNode
                        while let q = fail {
                            let index = pc.data.toInt() - 97
                            if let qc = q.child[index] {
                                pc.failNode = qc
                                break
                            }
                            fail = q.failNode
                        }
                        if fail == nil {
                            pc.failNode = root
                        }
                    }
                    queue.enqueue(pc)
                }
            }
        }
    }
    
    public func match(_ text: [Character]) {
        var p = root
        for i in 0..<text.count {
            let index = text[i].toInt() - 97
            // p 调整至 失败指针
            while let fail = p.failNode, p.child[index] == nil, p !== root {
                p = fail
            }
            // 匹配到，就继续下一个匹配，匹配不到，重新回到根节点
            if let pc = p.child[index] {
                p = pc
            } else {
                p = root
            }
            
            // 打印
            var tmp: AcTrieNode = p
            while tmp !== root {
                if tmp.isEndingChar {
                    let pos = i - tmp.length + 1
                    print(" 匹配起始下标 \(pos), 长度 \(tmp.length)")
                }
                if let fail = tmp.failNode {
                    tmp = fail
                } else {
                    break
                }
            }
        }
    }
    
}

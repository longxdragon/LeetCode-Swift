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

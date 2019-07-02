//
//  AVLTree.swift
//  LeetCode
//
//  Created by 许龙 on 2019/7/2.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

class AVLTreeNode <Key: Comparable, Value> {
    var key: Key!
    var val: Value!
    var left: AVLTreeNode?
    var right: AVLTreeNode?
    var height = 1
    
    init(key: Key, val: Value) {
        self.key = key
        self.val = val
    }
}

class AVLTree <Key: Comparable, Value> {
    var root: AVLTreeNode<Key, Value>?
    var size = 0
    
    var isEmpty: Bool {
        return size == 0
    }
    
    var isBalance: Bool {
        return isBalance(node: root)
    }
    
    // 获取节点的高度
    private func getHeight(node: AVLTreeNode<Key, Value>?) -> Int {
        if let n = node {
            return n.height
        }
        return 0
    }
    
    // 获取节点的平衡因子（左子树的高度 - 右子树的高度）
    private func getBalanceFactor(node: AVLTreeNode<Key, Value>?) -> Int {
        if let n = node {
            return getHeight(node: n.left) - getHeight(node: n.right)
        }
        return 0
    }
    
    // 是否是平衡二叉树
    private func isBalance(node: AVLTreeNode<Key, Value>?) -> Bool {
        if getBalanceFactor(node: node) > 1 {
            return false
        }
        return true
    }
    
    /**
     左旋转 针对 y 节点左旋，返回 x 节点
         y                           x
        / \                        /   \
       t4  x                      y     z
           / \       ------>     / \   / \
          t3  z                 t4 t3 t2 t1
              / \
             t2  t1
     */
    private func leftRote(node: AVLTreeNode<Key, Value>?) -> AVLTreeNode<Key, Value>? {
        if let y = node {
            let x = y.right
            let t3 = x?.left
            y.right = t3
            x?.left = y
            
            // 更新高度
            y.height = max(getHeight(node: y.left), getHeight(node: y.left)) + 1
            x?.height = max(getHeight(node: x?.left), getHeight(node: x?.right)) + 1
            return x
        }
        return node
    }
    
    /**
     右旋转 针对 y 节点右旋，返回 x 节点
            y                       x
           / \                    /   \
          x  t4                  z     y
         / \       ------>      / \   / \
        z  t3                  t1 t2 t3 t4
       / \
      t1 t2
     */
    private func rightRote(node: AVLTreeNode<Key, Value>?) -> AVLTreeNode<Key, Value>? {
        if let y = node {
            let x = y.left
            let t3 = x?.right
            y.left = t3
            x?.right = y
            
            // 更新高度
            y.height = max(getHeight(node: y.left), getHeight(node: y.left)) + 1
            x?.height = max(getHeight(node: x?.left), getHeight(node: x?.right)) + 1
            return x
        }
        return node
    }
    
    /**
     根据树的状态，来决定四种操作方式
     1、右旋
     2、先左旋，再右旋
     3、左旋
     4、先右旋，再左旋
     */
    private func changeBalance(node: AVLTreeNode<Key, Value>, balanceFactor: Int) -> AVLTreeNode<Key, Value>? {
        if abs(balanceFactor) < 1 {
            return node
        }
        if balanceFactor > 1 && getBalanceFactor(node: node.left) >= 0 {
            return rightRote(node: node)
        }
        if balanceFactor > 1 && getBalanceFactor(node: node.left) < 0 {
            node.left = leftRote(node: node.left)
            return rightRote(node: node)
        }
        if balanceFactor < -1 && getBalanceFactor(node: node.right) >= 0 {
            return leftRote(node: node)
        }
        if balanceFactor < -1 && getBalanceFactor(node: node.right) < 0 {
            node.right = rightRote(node: node.right)
            return leftRote(node: node)
        }
        return node;
    }
    
    // 添加一个节点，并返回根节点
    private func add(node: AVLTreeNode<Key, Value>?, key: Key, val: Value) -> AVLTreeNode<Key, Value>? {
        if let root = node {
            if key == root.key {
                root.val = val
            } else if key < root.key {
                root.left = add(node: node?.left, key: key, val: val)
            } else {
                root.right = add(node: node?.right, key: key, val: val)
            }
            root.height = max(getHeight(node: root.left), getHeight(node: root.right)) + 1
            
            let balanceFactor = getBalanceFactor(node: root)
            return changeBalance(node: root, balanceFactor: balanceFactor)
        } else {
            let node = AVLTreeNode(key: key, val: val)
            size += 1
            return node
        }
    }
    
    private func getNode(node: AVLTreeNode<Key, Value>?, key: Key) -> AVLTreeNode<Key, Value>? {
        if let root = node {
            if key == root.key {
                return root
            } else if key < root.key {
                return getNode(node: root.left, key: key)
            } else {
                return getNode(node: root.right, key: key)
            }
        }
        return nil
    }
    
    // 删除节点为 key 的节点，并返回删除后的根节点
    private func remove(node: AVLTreeNode<Key, Value>?, key: Key) -> AVLTreeNode<Key, Value>? {
        if let root = node {
            var retNode: AVLTreeNode<Key, Value>?
            
            if key < root.key {
                let dNode = remove(node: root.left, key: key)
                root.left = dNode
                retNode = root
                
            } else if key > root.key {
                let dNode = remove(node: root.right, key: key)
                root.right = dNode
                retNode = root
                
            } else {
                if root.left == nil {
                    return root.right
                }
                if root.right == nil {
                    return root.left
                }
                let mNode = minNode(node: root.right)!
                mNode.right = remove(node: root.right, key: mNode.key)
                mNode.left = root.left
                retNode = mNode
            }
            
            if let retNode = retNode {
                let balanceFactor = getBalanceFactor(node: retNode)
                return changeBalance(node: retNode, balanceFactor: balanceFactor)
            }
        }
        return nil
    }
    
    func add(key: Key, val: Value) {
        root = add(node: root, key: key, val: val)
    }
    
    func remove(key: Key) -> Value? {
        if let node = getNode(node: root, key: key) {
            root = remove(node: root, key: key)
            return node.val
        }
        return nil
    }
    
    // 找到子树上的最小节点
    func minNode(node: AVLTreeNode<Key, Value>?) -> AVLTreeNode<Key, Value>? {
        if node?.left == nil {
            return node
        }
        return minNode(node: node?.left)
    }
    
    // 前序遍历打印
    func preOrder(node: AVLTreeNode<Key, Value>?) {
        if let root = node {
            print("\(String(describing: root.val)) ", terminator: "")
            preOrder(node: root.left)
            preOrder(node: root.right)
        }
    }
    
    // 中序遍历打印
    func inOrder(node: AVLTreeNode<Key, Value>?) {
        if let root = node {
            inOrder(node: root.left)
            print("\(String(describing: root.val)) ", terminator: "")
            inOrder(node: root.right)
        }
    }
    
    // 后序遍历打印
    func postOrder(node: AVLTreeNode<Key, Value>?) {
        if let root = node {
            postOrder(node: root.left)
            postOrder(node: root.right)
            print("\(String(describing: root.val)) ", terminator: "")
        }
    }
    
}

//
//  BinarySearchTree.swift
//  LeetCode
//
//  Created by 许龙 on 2018/12/21.
//  Copyright © 2018 longxdragon. All rights reserved.
//

import Foundation

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    var parent: TreeNode?
    
    init(val: Int) {
        self.val = val
    }
    
    init(val: Int, parent: TreeNode) {
        self.val = val
        self.parent = parent
    }
}

/**
 ******* 二叉查找树 *******
 */
class BinarySearchTree {
    var tree: TreeNode?
    
    /**
     比当前节点小，就去左节点去找
     比当前节点大，就去右节点去找
     否则就是找到了
     */
    func find(_ val: Int) -> TreeNode? {
        var p: TreeNode? = tree
        while let n = p {
            if val < n.val {
                p = n.left
            } else if val > n.val {
                p = n.right
            } else {
                return p
            }
        }
        return nil
    }
    
    /**
     1、树为空的，就插入到根节点
     2、比当前节点小，并且没有左叶子节点，就插入到左节点
     3、比当前节点大，并且没有右叶子节点，就插入到右节点
     4、相等的，就当比当前节点大处理
     */
    func insert(_ val: Int) {
        if tree == nil {
            tree = TreeNode(val: val)
            return
        }
        
        var p: TreeNode? = tree
        while let n = p {
            if val < n.val {
                if n.left == nil {
                    n.left = TreeNode(val: val, parent: n)
                    return
                }
                p = n.left
            } else {
                if n.right == nil {
                    n.right = TreeNode(val: val, parent: n)
                    return
                }
                p = n.right
            }
        }
    }
    
    func delete(_ val: Int) {
        var p: TreeNode? = tree
        // p的父节点
        var pp: TreeNode?
        
        // 找到要删除的节点
        while let n = p, n.val != val {
            pp = p
            if val < n.val {
                p = n.left
            } else {
                p = n.right
            }
        }
        
        if let n = p {
            // 要删除的节点有两个节点
            if let _ = n.left, let right = n.right {
                var minNode = right
                var minParentNode = n
                // 找出右子树中最小节点
                while let minRight = minNode.right {
                    minParentNode = minNode
                    minNode = minRight
                }
                // 将minNode的值赋值给删除的节点
                n.val = minNode.val
                // 下面就是需要删除p节点
                p = minNode
                pp = minParentNode
            }
            
            // 只有左节点或者右节点
            var child: TreeNode?
            if let left = p?.left {
                child = left
            } else if let right = p?.right {
                child = right
            }
            
            // 删除对应的节点
            if let parentNode = pp {
                // 删除的节点处于父节点的左边
                if let left = parentNode.left, let n = p, left === n {
                    parentNode.left = child
                    child?.parent = parentNode
                } else {
                    parentNode.right = child
                    child?.parent = parentNode
                }
            } else {
                // 删除的是根节点
                tree = child
            }
        }
    }
    
    func findMax() -> TreeNode? {
        if var node = tree {
            while let n = node.right {
                node = n
            }
            return node
        }
        return nil
    }
    
    func findMin() -> TreeNode? {
        if var node = tree {
            while let n = node.left {
                node = n
            }
            return node
        }
        return nil
    }
    
    /**
     前驱节点 - 中序遍历的前一个节点
     */
    func findPreNode(_ node: TreeNode) -> TreeNode? {
        // 有左子树 -> 前驱节点就是左子树最右边的节点
        if var n = node.left {
            while let right = n.right {
                n = right
            }
            return n
        }
        // 无左子树 -> 找出当前节点是哪个节点的右子树最左边的节点
        var curNode = node
        var parentNode = node.parent
        // 当前节点是父节点的右节点 -> 父节点就是当前节点的前驱节点
        while let parent = parentNode, parent.right !== curNode {
            curNode = parent
            parentNode = parent.parent
        }
        return parentNode
    }
    
    /**
     后驱节点 - 中序遍历的后一个节点
     */
    func findNextNode(_ node: TreeNode) -> TreeNode? {
        // 有右子树 -> 前驱节点就是右子树最左边的节点
        if var n = node.right {
            while let left = n.left {
                n = left
            }
            return n
        }
        // 无右子树 -> 找出当前节点是哪个节点的左子树最右边的节点
        var curNode = node
        var parentNode = node.parent
        while let parent = parentNode, parent.left !== curNode {
            curNode = parent
            parentNode = parent.parent
        }
        return parentNode
    }
    
    /**
     前序遍历
     */
    func preOrder(_ node: TreeNode?) {
        if let n = node {
            print("\(n.val) ", terminator: "")
            preOrder(n.left)
            preOrder(n.right)
        }
    }
    
    /**
     中序遍历
     */
    func inOrder(_ node: TreeNode?) {
        if let n = node {
            inOrder(n.left)
            print("\(n.val) ", terminator: "")
            inOrder(n.right)
        }
    }
    
    /**
     后序遍历
     */
    func postOrder(_ node: TreeNode?) {
        if let n = node {
            postOrder(n.left)
            postOrder(n.right)
            print("\(n.val) ", terminator: "")
        }
    }
    
    /**
     按层遍历
     */
    func levelOrder() {
        guard let _ = tree else {
            return
        }
        // 借助队列，每次取出元素，都将左右子节点，压入队列
        let queue: LinkedQueue = LinkedQueue<TreeNode>()
        // 分行输出，就用了一个二维数组
        var results: Array = Array<Array<TreeNode>>()
        var levels: Array = Array<TreeNode>()
        
        var last: TreeNode? = tree
        var mlast: TreeNode?
        queue.enqueue(tree!)
        
        // 从队列逐一取出数据，就是按层遍历的顺序
        while let node = queue.dequeue() {
            levels.append(node)
            
            if let left = node.left {
                queue.enqueue(left)
                mlast = left
            }
            if let right = node.right {
                queue.enqueue(right)
                mlast = right
            }
            
            // 分层存储
            if node === last {
                results.append(levels)
                levels = Array<TreeNode>()
                last = mlast
            }
        }
        
        // 分层输出
        print("")
        for arr in results {
            for node in arr {
                print("\(node.val) ", terminator: "")
            }
            print("")
        }
    }
    
    /** -------------------- 翻转二叉树 --------------------- */
    func reverse(_ node: TreeNode?) {
        if let n = node {
            if n.left == nil, n.right == nil {
                return
            }
            
            let left = n.left
            n.left = n.right
            n.right = left
            
            reverse(n.left)
            reverse(n.right)
        }
    }
    
    /** -------------------- 是否完全对称 --------------------- */
    public var isSymmetrical: Bool {
        if let root = tree {
            return compareSymmetrical(root.left, root.right)
        }
        return false
    }
    
    private func compareSymmetrical(_ left: TreeNode?, _ right: TreeNode?) -> Bool {
        // 1、两边都没有节点
        if left == nil, right == nil {
            return true
        }
        // 2、两边都有节点，递归比较
        if let l = left, let r = right {
            if l.val != r.val {
                return false
            }
            return compareSymmetrical(left?.left, right?.right) && compareSymmetrical(left?.right, right?.left)
        }
        // 3、一个有，一个没有，肯定是不对称的
        return false
    }
    
    /** -------------------- 二叉树的深度 --------------------- */
    public func deep(_ node: TreeNode?) -> Int {
        if let root = node {
            let left = deep(root.left)
            let right = deep(root.right)
            return left > right ? left + 1 : right + 1
        }
        return 0
    }
    
    /** -------------------- 二叉树的宽度 --------------------- */
    public func width(_ node: TreeNode?) -> Int {
        if let root = node {
            let queue: LinkedQueue = LinkedQueue<TreeNode>()
            var deep = 1
            var max = 1
            var height = 0
            
            queue.enqueue(root)
            while queue.size > 0 {
                while deep > 0 {
                    if let node = queue.dequeue() {
                        if let left = node.left {
                            queue.enqueue(left)
                        }
                        if let right = node.right {
                            queue.enqueue(right)
                        }
                    }
                    deep -= 1
                }
                deep = queue.size
                max = max > deep ? max : deep
                // 二叉树深度的另外一种解法
                height += 1
            }
            return max
        }
        return 0
    }
}

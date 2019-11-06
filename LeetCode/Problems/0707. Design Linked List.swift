//
//  0707. Design Linked List.swift
//  LeetCode
//
//  Created by 许龙 on 2019/10/29.
//  Copyright © 2019 longxdragon. All rights reserved.
//

import Foundation

/**
 707. 设计链表
 https://leetcode-cn.com/problems/design-linked-list/
 */
class MyLinkedListNode {
    var val: Int;
    var next: MyLinkedListNode?;
    
    init(_ val: Int) {
        self.val = val;
    }
}

class MyLinkedList {
    var head: MyLinkedListNode;
    var tail: MyLinkedListNode?;
    
    init() {
        // 初始化，头结点跟尾节点都是同一个
        head = MyLinkedListNode(0);
    }
    
    func get(_ index: Int) -> Int {
        var i = 0;
        // 这边从 head.next 开始
        var node: MyLinkedListNode? = head.next;
        while i < index {
            node = node?.next;
            i += 1;
        }
        guard let n = node else {
            return -1;
        }
        return n.val;
    }
    
    func addAtHead(_ val: Int) {
        let node = MyLinkedListNode(val);
        guard let next = head.next else {
            // 链表为空时，也需要修改尾节点
            head.next = node
            tail = node;
            return;
        };
        head.next = node;
        node.next = next;
    }
    
    func addAtTail(_ val: Int) {
        // 直接修改尾节点
        let node = MyLinkedListNode(val);
        tail?.next = node;
        tail = node;
    }
    
    func addAtIndex(_ index: Int, _ val: Int) {
        if index < 0 {
            addAtHead(val);
            return;
        }
        var i = 0;
        // 这边从 head 开始，因为要插入，需要保留前结点
        var node: MyLinkedListNode? = head;
        while i < index {
            node = node?.next;
            i += 1;
        }
        if let n = node {
            // 下标没有越界，注意要修改尾节点
            let ne = MyLinkedListNode(val);
            guard let next = n.next else {
                n.next = ne;
                tail = ne;
                return;
            };
            n.next = ne;
            ne.next = next;
        } else {
            print("error : \(index) + \(val)");
        }
    }
    
    func deleteAtIndex(_ index: Int) {
        var i = 0;
        // 这边从 head 开始，因为要删除，需要保留前结点
        var node: MyLinkedListNode? = head;
        while i < index {
            node = node?.next;
            i += 1;
        }
        if let n = node {
            // 下标没有越界，注意要修改尾节点
            guard let next = n.next?.next else {
                n.next = nil;
                tail = n;
                return;
            };
            n.next = next;
        }
    }
    
    func printInfo() {
        var count = 0;
        var node: MyLinkedListNode? = head.next;
        var str = "";
        while let n = node {
            str += " -> \(n.val)";
            node = n.next;
            count += 1;
        }
        str = "( " + str + " ) total = \(count)";
        print(str);
    }
}

//
//  LeetCodeTests.swift
//  LeetCodeTests
//
//  Created by 许龙 on 2018/10/24.
//  Copyright © 2018 longxdragon. All rights reserved.
//

import XCTest
@testable import LeetCode

class LeetCodeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTwoAdd() {
        let test1 = TwoSum.init()
        print(test1.twoSum([3, 2, 3, 1, 2], 6))
    }
    
    func testExample() {
        let o = Recursion()
        print(o.walkStep(num: 7))
        print(o.walkStepWithoutStackOverFlow(num: 7))
    }
    
    func testPalindrome() {
        let m = PalindromeNumber.init()
        print(m.isPalindrome(10))
    }
    
    func testQueue() {
        print("\n testQueue:")
        let queue: CircularQueue = CircularQueue("0", 5)
        print(queue.enqueue("1"))
        print(queue.enqueue("2"))
        print(queue.enqueue("3"))
        print(queue.dequeue() as Any)
        print(queue.dequeue() as Any)
        print(queue.dequeue() as Any)
        print(queue.dequeue() as Any)
        print(queue.enqueue("4"))
        print(queue.enqueue("5"))
        print(queue.enqueue("6"))
        print(queue.enqueue("7"))
        print(queue.enqueue("8"))
        print(queue.enqueue("9"))
    }
    
    func testListNodeQueue() {
        print("\n testListNodeQueue:")
        let queue: LinkedQueue = LinkedQueue<String>()
        print(queue.enqueue("1"))
        print(queue.enqueue("2"))
        print(queue.enqueue("3"))
        print(queue.dequeue() as Any)
        print(queue.dequeue() as Any)
        print(queue.dequeue() as Any)
        print(queue.dequeue() as Any)
        print(queue.enqueue("4"))
        print(queue.dequeue() as Any)
        print(queue.enqueue("5"))
        print(queue.dequeue() as Any)
        print(queue.enqueue("6"))
        print(queue.dequeue() as Any)
    }
    
    func testSort() {
        let sort: Sort = Sort()
        // 冒泡排序
        print(sort.bubbleSort([4, 5, 6, 3, 2, 1, 1, 1, 1]))
        // 插入排序
        print(sort.insertionSort([4, 5, 6, 3, 2, 1, 1, 1, 1]))
        // 选择排序
        print(sort.selectionSort([4, 5, 6, 3, 2, 1, 1, 1, 1]))
        
        // 归并排序
        var items = [4, 5, 6, 3, 2, 1, 1, 1, 1]
        sort.mergeSort(&items)
        print(items)
        
        // 快速排序
        var items2 = [6, 5, 4, 3, 2, 1]
        sort.quickSort(&items2)
        print(items2)
        
        // 桶排序
        var items3 = [29, 25, 3, 49, 9, 37, 21, 43]
        sort.bucketSort(&items3, 5, 10)
        print(items3)
        
        // 计数排序
        print(sort.coutingSort([2, 5, 3, 0, 2, 3, 0, 3]))        
    }
    
    func  testFindMaxK() {
        let obj = FindMaxKNumber()
        var items = [3,2,1,5,6,4]
        print(obj.find(&items, 2))
    }
    
    func testSearch() {
        let search: Search = Search()
        XCTAssert(search.bSearch([1, 2, 3, 4, 5, 6, 7, 8], 5) == 4, "Pass")
        XCTAssert(search.bSearch([1], 5) == -1, "Pass")
        XCTAssert(search.bSearch([1], 1) == 0, "Pass")
        
        XCTAssert(search.bSearchFirst([1, 1, 3, 4, 6, 6, 7, 8], 6) == 4, "Pass")
        XCTAssert(search.bSearchEnd([1, 1, 3, 4, 6, 6, 7, 8], 6) == 5, "Pass")
        XCTAssert(search.bSearchFirstOrBigger([1, 1, 3, 4, 6, 6, 7, 8], 5) == 4, "Pass")
        XCTAssert(search.bSearchEndOrSmaller([1, 1, 3, 4, 6, 6, 7, 8], 3) == 2, "Pass")
        
        XCTAssert(search.bSearchCircleArray([2, 3, 4, 5, 7, 1], 3) == 1, "Pass")
    }
    
    func testMathSqrt() {
        let math: MathSqrt = MathSqrt()
        print(math.sqrt(0.01, 0.000001))
    }
    
    func testSkipList() {
        let obj = SkipList<Int>()
        obj.insert(2)
        obj.insert(3)
        obj.insert(1)
        obj.insert(3)
        obj.insert(7)
        obj.insert(9)
        obj.insert(4)
        obj.insert(2)
        obj.printAll()
        
        XCTAssertNotNil(obj.find(2), "Pass")
        XCTAssertNil(obj.find(5), "Pass")
        
        obj.delete(2)
        obj.delete(2)
        XCTAssertNil(obj.find(2), "Pass")
    }
    
    func testHashTable() {
        let obj = LineHashTable<String, String>(10, 0.75)
        obj["a"] = "A"
        obj["b"] = "B"
        obj["c"] = "C"
        obj["d"] = "D"
        obj["e"] = "E"
        obj["f"] = "F"
        obj["g"] = "G"
        print(obj.debugDescription)
        obj["h"] = "H"
        print(obj.debugDescription)
        
        obj["a"] = "A"
        obj["a"] = "B"
        obj["a"] = "C"
        obj["a"] = "D"
        obj["a"] = "E"
        
        obj["aa"] = "AA"
        print(obj.debugDescription)
        
        obj["i"] = "I"
        obj["j"] = "J"
        obj["k"] = "K"
        print(obj.debugDescription)
        
        if let val = obj["a"] {
            print(val)
        } else {
            print("None")
        }
        
        obj["bb"] = "BB"
        print(obj.debugDescription)
        
        obj["a"] = nil
        print(obj.debugDescription)
        
        if let val = obj["a"] {
            print(val)
        } else {
            print("None")
        }
        
        obj["1"] = "1"
        obj["2"] = "2"
        obj["3"] = "3"
        print(obj.debugDescription)
        
        obj["4"] = "4"
        obj["5"] = "5"
        obj["6"] = "6"
        obj["7"] = "7"
        obj["8"] = "8"
        obj["9"] = "9"
        obj["10"] = "10"
        print(obj.debugDescription)
        
        XCTAssert(obj.size == 22)
    }
    
    func testPermutations() {
        let obj = Permutations()
        var list = [1, 2, 2, 3, 4]
        obj.printPermutations(&list, 0, list.count-1)
    }
    
    func testHeap() {
        let obj = Heap(15, true)
        let list = [33, 27, 21, 16, 13, 15, 19, 5, 6, 7, 8, 1, 2, 12]
        for i in 0..<list.count {
            obj.insert(list[i])
        }
        obj.printAll()
        
        obj.removeMax()
        obj.printAll()
    }
    
    func testTopK() {
        let obj = TopK()
        print(obj.findTopK([15, 19, 5, 6, 7, 8, 33, 27, 21, 16, 13, 1, 2, 12], 4))
    }
    
    func testGraph() {
        let obj = Graph(10)
        obj.addEdge(0, 1)
        obj.addEdge(0, 3)
        obj.addEdge(1, 2)
        obj.addEdge(1, 4)
        obj.addEdge(2, 5)
        obj.addEdge(3, 4)
        obj.addEdge(4, 5)
        obj.addEdge(4, 6)
        obj.addEdge(5, 7)
        obj.addEdge(6, 7)
        
        obj.bfs(0, 6)
        obj.dfs(0, 6)
        obj.findRelation(0, 5)
    }
    
    func testStringMatch() {
        let obj = StringMatch()
        let string: Array<Character> = ["a", "b", "c", "a", "b", "d", "f", "a", "d"]
        
        XCTAssert(obj.matchBF(string, ["a", "b", "d", "f"]) == 3)
        XCTAssert(obj.matchBF(string, ["a", "b", "d", "a"]) == -1)
        
        XCTAssert(obj.matchRK(string, ["a", "b", "d", "f"]) == 3)
        XCTAssert(obj.matchRK(string, ["a", "b", "d", "a"]) == -1)
        
        XCTAssert(obj.matchBM(string, ["a", "b", "d", "f"]) == 3)
        XCTAssert(obj.matchBM(string, ["a", "b", "d", "a"]) == -1)
        
        XCTAssert(obj.matchKMP(string, ["a", "b", "d", "f"]) >= 0)
        XCTAssert(obj.matchKMP(string, ["a", "b", "d", "a"]) == -1)
    }
    
    func testTrie() {
        let obj = AcTrie()
        obj.insert(["a", "b", "f", "d"])
        obj.insert(["a", "d", "f"])
        obj.insert(["e", "f"])
        obj.insert(["b", "e", "f", "a"])
        
        obj.buildFailurePointer()
        obj.match(["a", "b", "e", "f", "a"])
    }
    
    
    func testMinCoin() {
        let o = MinCoin();
//        o.minCoinCountWithRollBack([1, 3, 5], 0, 9, 0);
//        o.minCoinCountWithDynamicProgramming([1, 3, 5], 9)
//        print(o.min);
        
        print(o.findLong([2, 9, 3, 6, 5, 1, 7]))
        print(o.findLong([2, 3, 4, 6, 7, 8, 9, 10, 5]))
    }
    
    
    func testSimpleNumber() {
        let so = Solution();
//        XCTAssertEqual(so.singleNumber3([1, 1, 64, 96]), [6, 4]);
        
//        XCTAssertEqual(so.majorityElement([1, 2]), [1, 2]);
        
//        XCTAssertEqual(so.searchMatrix([[1,3,5,7],[10,11,16,20],[23,30,34,50]], 3), true);
        
//        var nums1 = [2, 2, 3, 0, 0, 0];
//        let nums2 = [1, 2, 3];
//        so.merge(&nums1, 3, nums2, nums2.count);
//        XCTAssertEqual(nums1, [1, 2, 2, 2, 3, 3]);
        
//        XCTAssertEqual(so.superEggDrop(3, 14), 4);
        
//        XCTAssertEqual(so.shortestSubarray([48,99,37,4,-31], 144), 2);
        
//        XCTAssertEqual(so.maxSlidingWindow([1,3,-1,-3,5,3,6,7], 3), [3,3,5,5,6,7]);
        
//        XCTAssertEqual(so.isPalindrome("A man, a plan, a canal: Panama"), true);
//        XCTAssertEqual(so.isPalindrome("race a car"), false);
//        XCTAssertEqual(so.validPalindrome("aba"), true);
//        XCTAssertEqual(so.validPalindrome("abca"), true);
//        XCTAssertEqual(so.validPalindrome("aguokepatgbnvfqmgmlcupuufxoohdfpgjdmysgvhmvffcnqxjjxqncffvmhvgsymdjgpfdhooxfuupuculmgmqfvnbgtapekouga"), true);
        
//        XCTAssertEqual(so.partition("babad"), []);
//        XCTAssertEqual(so.longestPalindrome("babad"), "bab");
        
        
        XCTAssertEqual(so.findKthLargest([3,2,1,5,6,4], 2), 5);
    }
    
}

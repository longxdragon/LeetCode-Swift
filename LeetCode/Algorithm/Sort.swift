//
//  Sort.swift
//  LeetCode
//
//  Created by 许龙 on 2018/10/31.
//  Copyright © 2018 longxdragon. All rights reserved.
//

import Foundation

//
// 原地排序：空间复杂度O(1)
// 稳定性：待排序的序列中存在相等的元素，经过排序后，相等元素原有的先后顺序不变
//
class Sort {
    // 冒泡排序
    //
    // desc:
    // 两两比较，一次冒泡，找出最大的放到最后，依次类推
    //
    // 最好：O(n)
    // 最坏：O(n^2)
    // 平均：O(n^2)
    //
    // 原地排序、稳定算法
    func bubbleSort(_ items: Array<Int>) -> Array<Int> {
        var arr = items
        
        let n = arr.count
        if n == 1 {
            return arr
        }
        
        for i in 0..<n {
            var flag = false
            
            for j in 0..<n-i-1 {
                // 稳定排序算法，相等的不做操作
                if arr[j] > arr[j+1] {
                    let tmp = arr[j+1]
                    arr[j+1] = arr[j]
                    arr[j] = tmp
                    flag = true
                }
            }
            // 遍历下来，一个都不需要交换位置，就不需要再遍历了
            if !flag {
                break
            }
        }
        
        return arr
    }
    
    // 插入排序
    //
    // desc:
    // 从第二个开始，依次往前遍历，看看是否比之前的要小，小的话，就把比较的数往后移
    // 否则直接插入对应的位置
    //
    // 最好：O(n)   有序
    // 最坏：O(n^2) 倒序
    // 平均：O(n^2) 插入数组的搬运的平均是 O(n)，执行 n 次
    //
    // 原地排序、稳定算法
    func insertionSort(_ items: Array<Int>) -> Array<Int> {
        var arr = items
        
        let n = arr.count
        if n == 1 {
            return arr
        }
        
        for i in 1..<n {
            let val = arr[i]
            var k = i
            // 从后往前遍历，搬移数据的时候，就很简单
            for j in stride(from: i-1, through: 0, by: -1) {
                if arr[j] > val {
                    arr[j+1] = arr[j]
                    k = k - 1
                } else {
                    break
                }
            }
            arr[k] = val
        }
        
        return arr
    }
    
    // 选择排序
    //
    // desc:
    // 选择排序每次会从未排序区间中找到最小的元素，并与无序的第一个元素交换
    //
    // 最好：O(n^2)
    // 最坏：O(n^2)
    // 平均：O(n^2)
    //
    // 原地排序、非稳定算法
    func selectionSort(_ items: Array<Int>) -> Array<Int> {
        var arr = items
        
        let n = arr.count
        if n == 1 {
            return arr
        }
        
        for i in 0..<n-1 {
            // 找到无序内的最小值，与无序的第一个元素交换
            var min = arr[i]
            var k = i
            for j in i+1..<n {
                if min > arr[j] {
                    min = arr[j]
                    k = j
                }
            }
            arr[k] = arr[i]
            arr[i] = min
        }
        
        return arr
    }
    
    /**
     归并排序
     
     desc:
     分治思想，分而治之
     一个数组分成两个数组，两个数组再各自分成两个数组，直到只有无法拆分，分别把两个区域的数合成一个有序的区域
     自下而上
     
     最好：O(nlogn)
     最坏：O(nlogn)
     平均：O(nlogn) 与数据的有序度无关
     
     非原地排序"空间复杂度不为O(1)，而是为O(n)"、稳定算法“没有两个数的交换”
     */
    func mergeSort(_ items: inout Array<Int>) {
        mergeSort(&items, 0, items.count-1)
    }
    
    func mergeSort(_ items: inout Array<Int>, _ start: Int, _ end: Int) {
        if start >= end {
            return
        }
        
        let mid = (start + end)/2
        mergeSort(&items, start, mid)
        mergeSort(&items, mid+1, end)
        //merge(&items, start, mid, end)
        mergeWithPlaceholder(&items, start, mid, end)
    }
    // 未用哨兵
    func merge(_ items: inout Array<Int>, _ start: Int, _ mid: Int, _ end: Int) {
        var arr: Array<Int> = Array()
        var i = start
        var j = mid + 1
        
        while i <= mid && j <= end {
            if items[i] < items[j] {
                arr.append(items[i])
                i += 1
            } else {
                arr.append(items[j])
                j += 1
            }
        }
        
        // 把剩余的一个数组的后面内容，继续拼上
        var s = i
        var e = mid
        if j <= end {
            s = j
            e = end
        }
        for index in s...e {
            arr.append(items[index])
        }
        
        // 对应的位置赋值
        var sIndex = start
        for index in 0..<arr.count {
            items[sIndex] = arr[index]
            sIndex += 1
        }
    }
    // 哨兵解法
    func mergeWithPlaceholder(_ items: inout Array<Int>, _ start: Int, _ mid: Int, _ end: Int) {
        var leftArr: Array<Int> = Array()
        var rightArr: Array<Int> = Array()
        var i = 0
        var j = 0
        
        // 在两个数组后面各加上哨兵(最大值)，当一个数组到达哨兵位置后，就再也不会往后移动了，因为已经是最大的数值了
        for index in start...mid {
            leftArr.append(items[index])
        }
        leftArr.append(Int(INT_MAX))
        
        for index in mid+1...end {
            rightArr.append(items[index])
        }
        rightArr.append(Int(INT_MAX))
        
        for index in start...end {
            if leftArr[i] < rightArr[j] {
                items[index] = leftArr[i]
                i += 1
            } else {
                items[index] = rightArr[j]
                j += 1
            }
        }
    }
    
    
    /**
     快速排序
     
     desc:
     取任意值N，一次遍历，把所有比N小的放左边，比N大的放右边，然后再逐步排序左右两边的数据，依次类推
     自上而下的处理
     
     时间复杂度
     最好：O(nlogn)
     最坏：O(n^2) 完全有序的，[1,2,3,4,5] 依次遍历N，N-1，N-2，N-3 ... 1 次，总次数：N*(N+1)/2
     平均：O(nlogn)
     
     非原地排序、稳定算法
     */
    func quickSort(_ items: inout Array<Int>) {
        quickSort(&items, 0, items.count - 1)
    }
    
    func quickSort(_ items: inout Array<Int>, _ start: Int, _ end: Int) {
        if start >= end {
            return
        }
        let mid = partition(&items, start, end)
        quickSort(&items, start, mid-1)
        quickSort(&items, mid+1, end)
    }
    
    func partition(_ items: inout Array<Int>, _ start: Int, _ end: Int) -> Int {
        let val = items[end]
        var i = start
        for j in i..<end {
            if items[j] < val {
                // swap(i, j)
                let tmp = items[i]
                items[i] = items[j]
                items[j] = tmp
                i += 1
            }
        }
        // swap(i, end)
        items[end] = items[i]
        items[i] = val
        
        return i
    }
    
    
    /**
     桶排序
     
     desc:
     将一组数据，分配到n个桶中，然后对n个桶分别做快排，最后遍历所有桶合并数据
     
     时间复杂度：
     N数据分配成K个桶，每个桶的数据就是 N/K 个，快排 N/K*log(N/K)
     总的时间就是 K*N/K*log(N/K) 当 K 趋向于 N 时，log(N/K) 趋向于1
     最好：O(n)
     最坏：O(nlogn)
     最好：O(n)
     
     稳定算法、非原地排序O(n)
     */
    func bucketSort(_ items: inout Array<Int>, _ k: Int, _ range: Int) {
        if items.count <= 1 {
            return
        }
        // 创建n个桶
        var buckets = [Array<Any>]()
        for _ in 0..<k {
            let b = [Int]()
            buckets.append(b)
        }
        // 把所有数据放到对应的桶内
        for i in 0..<items.count {
            let index = items[i]/range
            if index < buckets.count {
                var list = buckets[index]
                list.append(items[i])
                buckets[index] = list
            }
        }
        // 对每个桶进行快速排序
        var i = 0
        for list in buckets {
            var b = list as! Array<Int>
            quickSort(&b)
            for k in 0..<b.count {
                items[i] = b[k]
                i += 1
            }
        }
    }
    
    
    /**
     计数排序：无数据比较，是线性排序（一种特殊的桶排序，每个桶里面都放相同的数据）
     
     desc:
     找出数组内的最大值，创建一个对应长度的数组，储存每个数值出现的次数
     转化计算出，小于等于此数值的个数，并储存在对应数值的下标位置
     创建新数组，根据对应下标的计数来确定具体的位置
     
     局限:
     只适用于数据量不大的场景，如果数据最大值 Max 比数组长度 N 要大很多，就不合适。
     只能给非负整数数排序，所有如果有负数、小数，需要转化后进行排序
     
     时间复杂度：
     最好：O(n)
     最坏：O(n)
     最好：O(n)
     
     稳定排序、非原地排序O(n)
     */
    func coutingSort(_ items: Array<Int>) -> Array<Int> {
        if items.count <= 1 {
            return items
        }
        // 找出最大值
        var max: Int = items[0]
        for i in 1..<items.count {
            if max < items[i] {
                max = items[i]
            }
        }
        // 累计计数
        var c: Array = Array(repeating: 0, count: max + 1)
        for i in 0..<items.count {
            c[items[i]] += 1
        }
        for i in 1..<c.count {
            c[i] = c[i - 1] + c[i]
        }
        // 必须倒序，要不然就不是稳定算法了
        var r: Array = Array(repeating: 0, count: items.count)
        for i in stride(from: items.count-1, through: 0, by: -1) {
            let index = c[items[i]] - 1
            r[index] = items[i]
            c[items[i]] -= 1
        }
        
        return r
    }
}

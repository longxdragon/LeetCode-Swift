//
//  Search.swift
//  LeetCode
//
//  Created by 许龙 on 2018/12/4.
//  Copyright © 2018 longxdragon. All rights reserved.
//

import Foundation


class Search {
    /**
     二分查找
     
     局限：
     1、必须是数组
     2、必须是有序的
     3、数据量太小，体现不出优势
     4、数据量太大，数组会放不下
     */
    func bSearch(_ items: Array<Int>, _ val: Int) -> Int {
        var low = 0
        var high = items.count - 1
        
        // 这边需要是<=，数组为1时，还会遍历一遍
        while low <= high {
            let mid = low + (high - low)/2
            if val < items[mid] {
                high = mid - 1
            } else if val > items[mid] {
                low = mid + 1
            } else {
                return mid
            }
        }
        
        return -1
    }
    
    // 递归实现
    func bSearchInternally(_ items: Array<Int>, _ val: Int) -> Int {
        return bSearchInternally(items, val, 0, items.count - 1)
    }
    
    func bSearchInternally(_ items: Array<Int>, _ val: Int, _ low: Int, _ high: Int) -> Int {
        if low <= high {
            let mid = low + (high - low)/2
            if val < items[mid] {
                return bSearchInternally(items, val, low, high - 1)
            } else if val > items[mid] {
                return bSearchInternally(items, val, low + 1, high)
            } else {
                return mid
            }
        }
        return -1
    }
    
    /**
     二分查找变种1：找到第一个等于给定值的元素
     */
    func bSearchFirst(_ items: Array<Int>, _ val: Int) -> Int {
        var low = 0
        var high = items.count - 1
        
        while low <= high {
            let mid = low + (high - low)/2
            if items[mid] < val {
                low = mid + 1
            } else if items[mid] > val {
                high = mid - 1
            } else {
                if mid == 0 || items[mid-1] != val {
                    return mid
                } else {
                    high = mid - 1
                }
            }
        }
        
        return -1
    }
    
    /**
     二分查找变种2：找到最后一个等于给定值的元素
     */
    func bSearchEnd(_ items: Array<Int>, _ val: Int) -> Int {
        var low = 0
        var high = items.count - 1
        
        while low <= high {
            let mid = low + (high - low)/2
            if items[mid] < val {
                low = mid + 1
            } else if items[mid] > val {
                high = mid - 1
            } else {
                if mid == items.count - 1 || items[mid+1] != val {
                    return mid
                } else {
                    low = mid + 1
                }
            }
        }
        
        return -1
    }
    
    /**
     二分查找变种3：找到第一个大于或者等于给定值的元素
     */
    func bSearchFirstOrBigger(_ items: Array<Int>, _ val: Int) -> Int {
        var low = 0
        var high = items.count - 1
        
        while low <= high {
            let mid = low + (high - low)/2
            if items[mid] < val {
                low = mid + 1
            } else {
                if mid == 0 || items[mid-1] < val {
                    return mid
                } else {
                    high = mid - 1
                }
            }
        }
        
        return -1
    }
    
    /**
     二分查找变种4：找到最后一个小于或等于给定值的元素
     */
    func bSearchEndOrSmaller(_ items: Array<Int>, _ val: Int) -> Int {
        var low = 0
        var high = items.count - 1
        
        while low <= high {
            let mid = low + (high - low)/2
            if items[mid] > val {
                high = mid - 1
            } else {
                if mid == items.count - 1 || items[mid+1] > val {
                    return mid
                } else {
                    low = mid + 1
                }
            }
        }
        
        return -1
    }
    
    /**
     二分查找：在循环数组中查询给定值的元素
     Note:
     每次二分，循环数组都会分成一个循环数组+有序数组
     */
    func bSearchCircleArray(_ items: Array<Int>, _ val: Int) -> Int {
        var low = 0
        var high = items.count - 1
        
        while low <= high {
            let mid = low + (high - low)/2
            if items[mid] == val {
                return mid
            }
            if items[low] <= items[mid] {
                // 有序数组
                if val >= items[low] && val < items[mid]  {
                    // 在范围内
                    high = mid - 1
                } else {
                    low = mid + 1
                }
            } else {
                // 循环数组
                low = mid + 1
            }
        }
        
        return -1
    }
}

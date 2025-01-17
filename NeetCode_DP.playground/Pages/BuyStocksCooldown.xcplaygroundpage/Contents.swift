
/*
 309. Best Time to Buy and Sell Stock with Cooldown
 
 You are given an array prices where prices[i] is the price of a given stock on the ith day.

 Find the maximum profit you can achieve. You may complete as many transactions as you like (i.e., buy one and sell one share of the stock multiple times) with the following restrictions:

 After you sell your stock, you cannot buy stock on the next day (i.e., cooldown one day).
 Note: You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).

  

 Example 1:

 Input: prices = [1,2,3,0,2]
 Output: 3
 Explanation: transactions = [buy, sell, cooldown, buy, sell]
 Example 2:

 Input: prices = [1]
 Output: 0
  

 Constraints:

 1 <= prices.length <= 5000
 0 <= prices[i] <= 1000
 */

import Foundation
import XCTest

class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        /// Buying: i + 1
        /// Selling: i + 2, because have to cool down

        var dp: [String: Int] = [:] /// key = (i, buying), value = prices[i]

        func dfs(_ i: Int, _ buying: Bool) -> Int {
            if i >= prices.count { return 0 }
            
            if let value = dp["\(i)\(buying)"] {
                return value
            }

            let cooldown = dfs(i + 1, buying)
            if buying {
                let buy = dfs(i + 1, !buying) - prices[i]
                dp["\(i)\(buying)"] = max(buy, cooldown)
            } else {
                let sell = dfs(i + 2, !buying) + prices[i]
                dp["\(i)\(buying)"] = max(sell, cooldown)
            }
            
            return dp["\(i)\(buying)"]!
        }

        return dfs(0, true)

    }
}

class SolutionTests: XCTestCase {
    func testExample() {
        let solution = Solution()
        XCTAssertEqual(solution.maxProfit([1, 2, 3, 0, 2]), 3)
    }
}

SolutionTests.defaultTestSuite.run()

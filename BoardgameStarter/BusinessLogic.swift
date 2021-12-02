//
//  BusinessLogic.swift
//  BoardgameStarter
//
//  Created by Rasmus Sejer on 30/05/2021.
//

import Foundation

class BusinessLogic {
    
}

extension Array {
    func split() -> (left: [Element], right: [Element]) {
        
        let count = self.count
        let half = count / 2
        
        let leftSplit = self[0 ..< half]
        let rightSplit = self[half ..< count]
        
        return (left: Array(leftSplit), right: Array(rightSplit))
    }
    
    func splitThree() -> (left: [Element], mid: [Element], right: [Element]){
        let count = self.count
        var firstThird = 0
        var mid = 0
        
        if count == 2 || count == 5 || count == 8 || count == 11 || count == 14 || count == 17 || count == 20 {
            firstThird = (count + 1) / 3
            mid = ((count + 1) / 3) + firstThird
            //print("seudocount = \(count + 1)")
        } else if count >= 23 {
            // Make some kind of alert to show that its not supported for lager groups
        } else {
            firstThird = count / 3
            mid = (count / 3) + firstThird
        }
        
        let leftSplit = self[0 ..< firstThird]
        let midSplit = self[firstThird ..< mid]
        let rightSplit = self[mid ..< count]
    
        return (left: Array(leftSplit), mid: Array(midSplit), right: Array(rightSplit))
    }
}

//
//  ExamFile.swift
//  BoardgameStarter
//
//  Created by Rasmus Sejer on 31/05/2021.
//

import Foundation

struct ExamFile {
    
    let optionalInt: Int?
    
    
    func unwrappers() {
        
        if let unwrappedInt = optionalInt {
            print("int was unwrapped + \(unwrappedInt)")
        } else {
            print("Still optional")
        }
    }
    
}

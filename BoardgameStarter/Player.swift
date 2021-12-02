//
//  Player.swift
//  BoardgameStarter
//
//  Created by Rasmus Sejer on 19/05/2021.
//

import Foundation

class Player {
    var playerId: String
    var name: String
    var isSelected: Bool
    var age: Int
    
init(playerId:String, name: String, isSelected: Bool, age: Int) {
    self.playerId = playerId
    self.name = name
    self.isSelected = isSelected
    self.age = age
}
//convenience init(playerId: String, name: String, age: Int) {
//    self.init(playerId: playerId, name: name, isSelected: false, age: age)
//}
}
struct PlayerOne {
    var playerId: String
    var name: String
    var isSelected: Bool
    var age: Int
}


//var player = Player(playerId: <#T##String#>, name: <#T##String#>, age: <#T##Int#>)
//var playerOne = PlayerOne(playerId: <#T##String#>, name: <#T##String#>, isSelected: <#T##Bool#>, age: <#T##Int#>)
    
    
    
 /*
class ViewModelItem {
        
    private var item: Player
        
    var isSelected = false
    var id: String {
        return item.playerId
    }
        
    init(item: Player){
        self.item = item
    }
}
 */
    
    /*
    init(name: String) {
        self.name = name
        self.playerId = ""
    }
    
    func getPlayerDict() -> [String: Any] {
        let dict:[String:Any] = [
            "playerName": self.name
        ]
        return dict
    }
 */

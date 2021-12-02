//
//  FirebaseService.swift
//  BoardgameStarter
//
//  Created by Rasmus Sejer on 19/05/2021.
//

import Foundation
import Firebase


class FirebaseService {
    
    private var PLAYERS_COLLECTION = "players"
    
    var players = [Player]() // empty array
    
    
    var selectedPlayers = [Player]()
    
    

    
    func playerIsSelected(player: Player) -> Bool {
        return player.isSelected == true
    }

    var selectedItems: [Player] {
        return players.filter(playerIsSelected(player:))
    }
    
//
//
//4
    
//    var selectedItems: [Player] {
//        return players.filter {$0.isSelected == true}
//    }


//3
    
//var selectedItems: [Player] {
//    return players.filter { (player) -> Bool in
//        player.isSelected == true
//    }
//}
    
//    var selectedItems: [Player] {
//        return players
//            .filter(<#T##isIncluded: (Player) throws -> Bool##(Player) throws -> Bool#>)
//    }

//    var selectedItems: [Player]   {
        // returns a sorted array of the elements in the array that satisfy the given predicate
        //return players.filter { $0.isSelected == true }
//        return players.filter { (player) -> Bool in
//            player.isSelected == true
//        }
//        return players.filter(playerIsSelected(player:))
//       }
//
    var infoMessage:String = ""
    
    private var db = Firestore.firestore()
    
    var updatable: Updatable?
    var viewController = ViewController()
    
    //var aPlayer = Player(name: "Camma")
    
    func startListener() {
        // listens to entire collection (Data heavy)
        db.collection(PLAYERS_COLLECTION).addSnapshotListener { (snap, error) in
            if let e = error {
                print("Error: \(e)")
            } else {
                if let s = snap { // unwrapping snap since its an optional
                    self.players.removeAll()
                    for document in s.documents { // if there is a value -> loop though collection
                        if let name = document.data()["name"] as? String {
                            let age = document.data()["age"] as? Int ?? 0
                            
                            let aPlayer = Player(playerId: document.documentID, name: name, isSelected: false, age: age)
                            //let bPlayer = Player(playerId: document.documentID, name: name, age: age)
                            self.players.append(aPlayer)
                            //print(self.players.map { $0.isSelected })
                        }
                    }
                    self.updatable?.update(obj: nil)
                }
            }
            
        }
    }
    
    // returns 0 if no players selected from list
    func getCountOfSelectedPlayers() -> Int {
        //print(self.players.map { $0.isSelected })
        
        print(self.players.map({ (player) -> Bool in
            player.isSelected == true
        }))
            
        selectedPlayers.removeAll()
        for player in players {
            
            if player.isSelected == true {
                selectedPlayers.append(player)
            }
        }
        //print("These players were selected: \(selectedPlayers)")
        print("Number of players selected: \(selectedPlayers.count)")
        return selectedPlayers.count
    }
    
    var playerExists: Bool = false
    func addPlayer(name: String, id: String, age: Int){
        
        let docRef = db.collection(PLAYERS_COLLECTION).document(id) // Creates a new document
            
        docRef.getDocument{(document, error) in
                if let document = document, document.exists {
                    
                    print("Player already exists \(document.documentID)")
                    self.playerExists = true
                } else {
                    if name.count > 0 {
                        var data = [String:Any]() // Creates a new empty dictionary (map)
                        data["name"] = name// Data is added to the map
                        data["age"] = age
                        docRef.setData(data) // Saves to firebase
                        self.playerExists = false
                    }
                }
            }
    }
    
    func deletePlayer(index: Int){
        if index < players.count {
            let documentId = players[index].playerId
            db.collection(PLAYERS_COLLECTION).document(documentId).delete() { (error) in
                if let e = error {
                    print("Error while deleting item: \(documentId) - Error: \(e)")
                } else {
                    print("\(documentId) was deleted from the firestore")
                }
            }
            players.remove(at: index)
        }
    }
    

    
}

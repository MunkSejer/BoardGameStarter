//
//  ArrayViewController.swift
//  BoardgameStarter
//
//  Created by Rasmus Sejer on 31/05/2021.
//

import UIKit

class ArrayViewController: UIViewController {
    
    var playerArray: [Player] = []
    

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let arrayString = printNamesFromArray()
        
        textView.text = arrayString

        // Do any additional setup after loading the view.
    }
    
    func printNamesFromArray() -> String{
        
        var temp = ""
        for player in playerArray {
            let name = player.playerId
            let age = player.age
            temp.append("\(name) - Age: \(age)\n")
        }
        return temp
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

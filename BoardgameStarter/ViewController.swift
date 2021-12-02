//
//  ViewController.swift
//  BoardgameStarter
//
//  Created by Rasmus Sejer on 19/05/2021.
//

import UIKit


let firebaseService = FirebaseService()

class ViewController: UIViewController, Updatable {
   
    var numberOfPlayersSelected: Int?
    private var myTextField : UITextField?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Makes label invisible to begin with
        configureUILabel(label: topInfoLabel)
        
        tableView.delegate = self
        tableView.dataSource = self
    
        self.tableView.allowsMultipleSelection = true
        self.tableView.allowsMultipleSelectionDuringEditing = true

    
        firebaseService.updatable = self
        firebaseService.startListener()
        // Do any additional setup after loading the view.
    }
    
    // Sætter navigations title og knapper
    override func viewWillLayoutSubviews() {
        navigationItem.title = "Player List"
    }
    
    @IBAction func leftBarBtnPressed() {
        self.presentAlertController()
        print("Adding player...")
    }
    
@IBAction func rightBarBtnPressed(){
    numberOfPlayersSelected = firebaseService.getCountOfSelectedPlayers()
    if let players = numberOfPlayersSelected {
        if players < 2 {
            topInfoLabel.alpha = 1
            topInfoLabel.text = "Please select 2 or more people from the list."
        } else {
            print("Segue performed...")
            performSegue(withIdentifier: "rootSegue", sender: self)
        }
    }
}
    
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destinationViewController = segue.destination as? LogicViewController {
        destinationViewController.playerArray = firebaseService.selectedItems
    }
}
    
//    @IBAction func showTextViewPressed(_ sender: Any) {
//        performSegue(withIdentifier: "arraySegue", sender: self)
//
//    }
    
    @IBAction func resetSelected(){
        tableView.deselectAllRows(animated: true)
        topInfoLabel.alpha = 0
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        topInfoLabel.alpha = 0
    }
    
    func update(obj: NSObject?) {
        tableView.reloadData() // updates tableView
    }
    
    func presentAlertController() {
        let alertController = UIAlertController(title: "Enter Player Name",
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Age"
        }
            
            let abortAction = UIAlertAction(title: "Abort", style: .destructive) { (action) in
                return
            }
            
            let continueAction = UIAlertAction(title: "Continue",
                                               style: .default) { [weak alertController] _ in
                                                // guard let to ensure that the textfield is not nil
                                                guard let textFields = alertController?.textFields else {
                                                    return
                                                    
                                                }
                                                // Unwrapping text for textField
                                                // e.g if the text for the textField is not nil, the print will execute
                                                if let nameText = textFields[0].text {
                                                    print("Name: \(nameText)")
                                                    if let ageText = textFields[1].text {
                                                        let age = Int(ageText) ?? 0
                                                    print("Age: \(ageText)")
                                                        firebaseService.addPlayer(name: nameText, id: nameText, age: age)
                                                    
                                                    // Not working properly
//                                                    if firebaseService.playerExists == true {
//                                                         //ALERT
//                                                        let alert = UIAlertController(title: "Player Already Exist", message: nil, preferredStyle:                                                                .alert)
//                                                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//                                                        self.present(alert, animated: true)
                                                        
                                                    }
                                                }
            
            }
            alertController.addAction(abortAction)
            alertController.addAction(continueAction)
            
        
        
        self.present(alertController,
                     animated: true)
        
    }
    
    func configureUILabel(label: UILabel){
        label.textColor = .white
        label.backgroundColor = UIColor.lightGray
        
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15
        label.alpha = 0
        
//        label.layer.shadowColor = UIColor.black.cgColor
//        label.layer.shadowRadius = 3.0
//        label.layer.shadowOpacity = 1.0
//        label.layer.shadowOffset = CGSize(width: 4, height: 4)
    }
    
}
    


extension UITableView {
    func deselectAllRows(animated: Bool) {
        // returns an array of indexpaths where rows are selected
        guard let selectedRows = indexPathsForSelectedRows else {
            return
        }
        for indexPath in selectedRows {
            deselectRow(at: indexPath, animated: animated)
            firebaseService.players[indexPath.row].isSelected = false
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentPlayer = firebaseService.players[indexPath.row].name
        firebaseService.players[indexPath.row].isSelected = true
        print("\(currentPlayer) - selected state: \(firebaseService.players[indexPath.row].isSelected)")
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let currentPlayer = firebaseService.players[indexPath.row].name
        firebaseService.players[indexPath.row].isSelected = false
        print("\(currentPlayer) - selected state: \(firebaseService.players[indexPath.row].isSelected)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firebaseService.players.count
    }
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! CustomCell
        cell.customCellLabel.text = String(firebaseService.players[indexPath.row].playerId)
        return cell as UITableViewCell
}
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            firebaseService.deletePlayer(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
}


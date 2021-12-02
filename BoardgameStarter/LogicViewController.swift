//
//  LogicViewController.swift
//  BoardgameStarter
//
//  Created by Rasmus Sejer on 23/05/2021.
//

import UIKit

class LogicViewController: UIViewController {
    
    var playerArray = [Player]()
    
    @IBOutlet weak var startingPlayerBtn: UIButton!
    @IBOutlet weak var makeTwoBtn: UIButton!
    @IBOutlet weak var makeThreeBtn: UIButton!
    @IBOutlet weak var backBtn: UIBarButtonItem!
    
    @IBOutlet weak var starterLabel: UILabel!
    @IBOutlet weak var groupOneLabel: UILabel!
    @IBOutlet weak var groupTwoLabel: UILabel!
    @IBOutlet weak var groupThreeLabel: UILabel!

    
    @IBOutlet weak var headerStarter: UILabel!
    @IBOutlet weak var headerTeamOne: UILabel!
    @IBOutlet weak var headerTeamTwo: UILabel!
    @IBOutlet weak var headerTeamThree: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelAlphas(alpha: 0)
        configureHeaderUILabel(label: headerStarter)
        configureHeaderUILabel(label: headerTeamOne)
        configureHeaderUILabel(label: headerTeamTwo)
        configureHeaderUILabel(label: headerTeamThree)
        
        configureUiButton(button: startingPlayerBtn)
        configureUiButton(button: makeTwoBtn)
        configureUiButton(button: makeThreeBtn)
    
    }
    
    override func viewWillLayoutSubviews() {
        navigationItem.title = "Single || Group"
    }
    
    @IBAction func leftBarBtnPressed(){
        performSegue(withIdentifier: "unwindToPlayerList", sender: self)
        print("Unwinding...")
    }
 
    @IBAction func rightBarBtnPressed(){
        startingPlayerBtn.isEnabled = true
        makeTwoBtn.isEnabled = true
        makeThreeBtn.isEnabled = true
        
        setLabelAlphas(alpha: 0)
    }
    
    @IBAction func selectStartingPlayerPressed(_ sender: UIButton) {
        selectPlayerStarting()
    }
    
    @IBAction func makeTwoGroupsPressed(_ sender: UIButton) {
        makeTwoGroups()
    }
    
    @IBAction func makeThreeGroupsPressed(_ sender: UIButton) {
        makeThreeGroups()
    }
    
    
    func selectPlayerStarting(){
        
        let playerStarting = playerArray.randomElement()!
        
        
        headerStarter.alpha = 1
        starterLabel.alpha = 1
        starterLabel.text = playerStarting.playerId
        
        startingPlayerBtn.isEnabled = false
    }
    
    func makeTwoGroups() {
        
        headerTeamOne.alpha = 1
        headerTeamTwo.alpha = 1
        groupOneLabel.alpha = 1
        groupTwoLabel.alpha = 1
        
        groupOneLabel.text?.removeAll()
        groupTwoLabel.text?.removeAll()
        
        headerTeamThree.alpha = 0
        groupThreeLabel.text?.removeAll()
        
let shuffledArray = playerArray.shuffled()
let splitArray = shuffledArray.split()

let teamOne = gatherTeamMembers(array: splitArray.left)
let teamTwo = gatherTeamMembers(array: splitArray.right)

groupOneLabel.text = teamOne
groupTwoLabel.text = teamTwo
        
        makeTwoBtn.isEnabled = false
    }
    
    func makeThreeGroups(){
        groupOneLabel.alpha = 1
        groupTwoLabel.alpha = 1
        groupThreeLabel.alpha = 1
        
        headerTeamOne.alpha = 1
        headerTeamTwo.alpha = 1
        headerTeamThree.alpha = 1
        
        groupOneLabel.text?.removeAll()
        groupTwoLabel.text?.removeAll()
        groupThreeLabel.text?.removeAll()
        
        let shuffledArray = playerArray.shuffled()
        let splitArray = shuffledArray.splitThree()
        
        let teamOne = gatherTeamMembers(array: splitArray.left)
        let teamTwo = gatherTeamMembers(array: splitArray.mid)
        let teamThree = gatherTeamMembers(array: splitArray.right)
        
        groupOneLabel.text = teamOne
        groupTwoLabel.text = teamTwo
        groupThreeLabel.text = teamThree
        
        makeThreeBtn.isEnabled = false
    }
    

    func gatherTeamMembers(array: Array<Player>) -> String {
        var team = ""
        for player in array {
            let name = player.playerId
            team.append("\(name) ")
        }
        return team
    }
    
    func setLabelAlphas(alpha: Int){
        starterLabel.alpha = CGFloat(alpha)
        groupOneLabel.alpha = CGFloat(alpha)
        groupTwoLabel.alpha = CGFloat(alpha)
        groupThreeLabel.alpha = CGFloat(alpha)
        headerStarter.alpha = CGFloat(alpha)
        headerTeamOne.alpha = CGFloat(alpha)
        headerTeamTwo.alpha = CGFloat(alpha)
        headerTeamThree.alpha = CGFloat(alpha)
    }
    
    func configureHeaderUILabel(label: UILabel){
        label.textColor = .white
        label.backgroundColor = UIColor.lightGray
        
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        
        label.preferredMaxLayoutWidth = 100
        
//        label.layer.borderWidth = 2
//        label.layer.borderColor = .none
        
//        label.layer.shadowColor = UIColor.black.cgColor
//        label.layer.shadowRadius = 3.0
//        label.layer.shadowOpacity = 1.0
//        label.layer.shadowOffset = CGSize(width: 4, height: 4)
    }
    
    func configureUiButton(button: UIButton) {
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setTitleColor(UIColor.white, for: .disabled)
        
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: -1.0, height: -1.0)
    
    }
    
    
}



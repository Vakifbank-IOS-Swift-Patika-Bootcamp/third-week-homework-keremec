//
//  hireSitterVC.swift
//  zooManageApp
//
//  Created by Kerem Safa Dirican on 18.11.2022.
//

import UIKit

class HireSitterVC: UIViewController {
    
    weak var delegateHireSitter:HomeVC?
    
    @IBOutlet weak var nameInput: UITextField!
    
    @IBOutlet weak var ageInput: UITextField!
    
    @IBOutlet weak var marriedSwitch: UISwitch!
    
    @IBOutlet weak var salaryFactorInput: UITextField!
    
    @IBOutlet weak var salaryLabel: UILabel!
    
    @IBOutlet weak var hireButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func ageChanged(_ sender: Any) {
        updateSalary()
    }
    
    @IBAction func salaryFactorChanged(_ sender: Any) {
        updateSalary()
    }
    
    
    @IBAction func hireAction(_ sender: Any) {
        guard let name = nameInput.text else {return}
        guard let age = Int(ageInput.text ?? "error") else {return}
        guard let salaryFactor = Int(salaryFactorInput.text ?? "error") else {return}
        let isMarried = marriedSwitch.isEnabled
        let id = (delegateHireSitter?.zoo.animalSitters.last?.id ?? 0) + 1
        let sitter = AnimalSitter(id: id, name: name, age: age, isMarried: isMarried, salaryFactor: salaryFactor)
        delegateHireSitter?.zoo.addAnimalSitter(person: sitter)
        delegateHireSitter?.viewWillAppear(false)
        self.dismiss(animated: true)
    }
    
    
    func updateSalary(){
        hireButton.isEnabled = false
        var salaryValue:Int
        guard let age = Int(ageInput.text ?? "error") else {return}
        guard let salaryFactor = Int(salaryFactorInput.text ?? "error") else {return}
        salaryValue = salaryFactor + age * 75
        salaryLabel.text = "\(salaryValue)₺"
        hireButton.isEnabled = true
    }
}

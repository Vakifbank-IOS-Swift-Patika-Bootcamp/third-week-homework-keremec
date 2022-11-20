//
//  NewdevVC.swift
//  techCompanyApp
//
//  Created by Kerem Safa Dirican on 17.11.2022.
//

import UIKit

class NewdevVC: UIViewController {
    weak var delegateNewdev:HomeVC?
    var currentSegment = DevLevel.jr
    
    @IBOutlet weak var nameInput: UITextField!
    
    @IBOutlet weak var ageInput: UITextField!
    
    @IBOutlet weak var marriedSwitch: UISwitch!
    
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    
    @IBOutlet weak var salaryFactorInput: UITextField!
    
    @IBOutlet weak var salaryLabel: UILabel!
    
    @IBOutlet weak var addDeveloperOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addDeveloper(_ sender: Any) {
        guard let name = nameInput.text else {return}
        guard let age = Int(ageInput.text ?? "error") else {return}
        guard let salaryFactor = Int(salaryFactorInput.text ?? "error") else {return}
        let isMarried = marriedSwitch.isEnabled
        let dev = Developer(name: name, age: age, isMarried: isMarried, experience: currentSegment, salaryFactor: salaryFactor)
        delegateNewdev?.company.hireDeveloper(dev: dev)
        delegateNewdev?.viewWillAppear(false)
        self.dismiss(animated: true)
    }
    
    
    @IBAction func segmentChanged(_ sender: Any) {
        switch segmentOutlet.selectedSegmentIndex {
        case 0:
            currentSegment = DevLevel.jr
        case 1:
            currentSegment = DevLevel.mid
        case 2:
            currentSegment = DevLevel.sr
        default:
            currentSegment = DevLevel.jr
        }
        updateSalary()
    }
    
    
    @IBAction func salaryFactorChanged(_ sender: Any) {
        updateSalary()
    }
    
    @IBAction func ageChanged(_ sender: Any) {
        updateSalary()
    }
    
    func updateSalary(){
        addDeveloperOutlet.isEnabled = false
        var salaryValue = 0
        guard let age = Int(ageInput.text ?? "error") else {return}
        guard let salaryFactor = Int(salaryFactorInput.text ?? "error") else {return}
        let ageBonus = age > 20 ? age - 20 : 0
        switch currentSegment {
        case .jr:
            salaryValue =  (15) * salaryFactor
        case .mid:
            salaryValue = (20 + ageBonus) * salaryFactor
        case .sr:
            salaryValue = (30 + ageBonus) * salaryFactor
        }
        salaryLabel.text = "\(salaryValue)₺"
        addDeveloperOutlet.isEnabled = true
    }
}

//
//  ViewController.swift
//  zooManageApp
//
//  Created by Kerem Safa Dirican on 18.11.2022.
//

import UIKit

class HomeVC: UIViewController {
    let zoo = Zoo(name: "Zooland", year: 2000, budget: 150000, water: 1000)
    
   
    @IBOutlet weak var companyName: UILabel!
    
    @IBOutlet weak var companyDate: UILabel!
    
    @IBOutlet weak var companyBudget: UITextField!
    
    @IBOutlet weak var companyWater: UITextField!
    
    @IBOutlet weak var paySalaryCount: UIButton!
    
    @IBOutlet weak var useWaterCount: UIButton!
    
    @IBOutlet weak var addAnimalOutlet: UIButton!
    
    @IBOutlet weak var listButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyName.text = zoo.name
        companyDate.text = String(zoo.year)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateExpenses()
        updateBudget()
        updateWater()
        updateButtons()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toListVC":
            let goalVC = segue.destination as! ListVC
            goalVC.delegateListVC = self
        case "toHireAnimalVC":
            let goalVC = segue.destination as! HireAnimalVC
            goalVC.delegateHireAnimal = self
        case "toHireSitterVC":
            print("hey")
            let goalVC = segue.destination as! HireSitterVC
            goalVC.delegateHireSitter = self
            print("huy")
        default:
            print("no identifier found")
        }
    }

    @IBAction func removeBudget(_ sender: Any) {
        let value = UInt(companyBudget.text ?? "0")
        zoo.removeFunds(value ?? UInt(0))
        updateBudget()
    }
    
    @IBAction func addBudget(_ sender: Any) {
        let value = UInt(companyBudget.text ?? "0")
        zoo.addFunds(value ?? UInt(0))
        updateBudget()
    }
    
    @IBAction func removeWater(_ sender: Any) {
        let value = Int(companyWater.text ?? "0") ?? 0
        zoo.editWater(water: -value)
        updateWater()
    }
    
    @IBAction func addWater(_ sender: Any) {
        let value = Int(companyWater.text ?? "0") ?? 0
        zoo.editWater(water: value)
        updateWater()
    }
    
    
    @IBAction func listPersonel(_ sender: Any) {
        performSegue(withIdentifier: "toListVC", sender: nil)
    }
    
    @IBAction func addSitterAction(_ sender: Any) {
        performSegue(withIdentifier: "toHireSitterVC", sender: nil)
    }
    
    @IBAction func addAnimalAction(_ sender: Any) {
        performSegue(withIdentifier: "toHireAnimalVC", sender: nil)
    }
    
    @IBAction func paySalary(_ sender: Any) {
        zoo.paySalaries()
        updateBudget()
    }
    
    @IBAction func useWater(_ sender: Any) {
        zoo.useWater()
        updateWater()
    }
    
    
}

extension HomeVC{
    
    func updateBudget(){
        companyBudget.placeholder = "\(zoo.budget)₺"
        companyBudget.text = nil
        companyBudget.endEditing(true)
    }
    
    func updateWater(){
        companyWater.placeholder = "\(zoo.water)L"
        companyWater.text = nil
        companyWater.endEditing(true)
    }
    
    func updateExpenses(){
        paySalaryCount.setTitle("\(zoo.salaryCount)₺", for: .normal)
        useWaterCount.setTitle("\(zoo.waterExpenseCount)L", for: .normal)
        paySalaryCount.isEnabled = zoo.salaryCount > 0 ? true : false
        useWaterCount.isEnabled = zoo.waterExpenseCount > 0 ? true : false
    }
    
    func updateButtons(){
        addAnimalOutlet.isEnabled = zoo.animalSitterCount > 0 ? true : false
        listButtonOutlet.isEnabled = zoo.animalSitterCount > 0 ? true : false
    }
}


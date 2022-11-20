//
//  ViewController.swift
//  techCompanyApp
//
//  Created by Kerem Safa Dirican on 17.11.2022.
//

import UIKit

class HomeVC: UIViewController {
    
    let company = TechCompany(name: "Tech Company", year: 2022, budget: 35000)
    
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyYear: UILabel!
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var devCount: UIButton!
    @IBOutlet weak var salaryCount: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyName.text = company.name
        companyYear.text = String(company.year)
    }

    override func viewWillAppear(_ animated: Bool) {
        updateBudget()
        updateWorkers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toNewdev":
            let goalVC = segue.destination as! NewdevVC
            goalVC.delegateNewdev = self
        case "toDevlist":
            let goalVC = segue.destination as! DevlistVC
            goalVC.company = company
        default:
            print("no identifier found")
        }
    }
    
    @IBAction func removeFunds(_ sender: Any) {
        let value = UInt(textBox.text ?? "0")
        company.removeFunds(value ?? UInt(0))
        updateBudget()
    }
    
    @IBAction func addFunds(_ sender: Any) {
        let value = UInt(textBox.text ?? "0")
        company.addFunds(value ?? UInt(0))
        updateBudget()
    }
    
    @IBAction func paySalaries(_ sender: Any) {
        company.paySalaries()
        updateBudget()
        updateWorkers()
    }
    
    
    @IBAction func openDevlist(_ sender: Any) {
        performSegue(withIdentifier: "toDevlist", sender: nil)
    }
    @IBAction func newDeveloper(_ sender: Any) {
        performSegue(withIdentifier: "toNewdev", sender: nil)
    }
    
}



extension HomeVC{
    func updateBudget(){
        textBox.placeholder = "\(company.budget)₺"
        textBox.text = nil
        textBox.endEditing(true)
    }
    
    func updateWorkers(){
        devCount.setTitle(String(company.developerCount), for: .normal)
        salaryCount.setTitle("\(company.salarySum)₺", for: .normal)
        devCount.isEnabled = company.developerCount > 0 ? true : false
        salaryCount.isEnabled = company.salarySum > 0 ? true : false
    }

}



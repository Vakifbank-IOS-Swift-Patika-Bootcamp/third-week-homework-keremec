//
//  hireAnimalVC.swift
//  zooManageApp
//
//  Created by Kerem Safa Dirican on 18.11.2022.
//

import UIKit

class HireAnimalVC: UIViewController {
    
    weak var delegateHireAnimal:HomeVC?

    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    
    @IBOutlet weak var nameInput: UITextField!
    
    @IBOutlet weak var idInput: UITextField!
    
    @IBOutlet weak var buttonOutlet: UIButton!
    
    @IBOutlet weak var errorOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func buttonAction(_ sender: Any) {
        guard let name = nameInput.text else {return}
        guard let id = Int(idInput.text ?? "error") else {
            errorOutlet.text = "Invalid Sitter ID"
            return
        }
        let sitterIndex = checkID(id: id)
        guard sitterIndex != -1 else {
            errorOutlet.text = "Invalid Sitter ID"
            return
            
        }
        let selectedSegmentIndex = segmentOutlet.selectedSegmentIndex
        
        switch selectedSegmentIndex{
        case 0:
            let cat = Cat(name: name)
            delegateHireAnimal?.zoo.animalSitters[sitterIndex].addAnimal(animal: cat)
        case 1:
            let dog = Dog(name: name)
            delegateHireAnimal?.zoo.animalSitters[sitterIndex].addAnimal(animal: dog)
        default:
            return
        }
        
        delegateHireAnimal?.viewWillAppear(false)
        self.dismiss(animated: true)
        
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
    }
    
    func checkID(id:Int)->Int{
        for (i,e) in delegateHireAnimal!.zoo.animalSitters.enumerated(){
            if e.id == id{
                return i
            }
        }
        return -1
    }
    
}

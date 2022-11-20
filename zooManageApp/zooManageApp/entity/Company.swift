//
//  Company.swift
//  zooManageApp
//
//  Created by Kerem Safa Dirican on 18.11.2022.
//

import Foundation

//MARK: - Question 1
enum AnimalType:String {
    case cat = "😺 Cat"
    case dog = "🐶 Dog"
}

protocol Labor{
    var name:String {get set}
    var age:Int {get set}
    var isMarried:Bool {get set}
    var salaryFactor:Int {get set}
    var salary:Int {get}
}


protocol Company{
    var name:String {get set}
    var year:Int {get set}
    var budget:Int {get}
    
    func addFunds(_ value:UInt)
    func removeFunds(_ value:UInt)
    func paySalaries()
}

class Zoo:Company{
    var name: String
    var year: Int
    var budget: Int
    var water: Int
    var animalSitters: [AnimalSitter]
    var animalSitterCount: Int{
        return animalSitters.count
    }
    var salaryCount:Int{
        var salary = 0
        for i in animalSitters{
            salary += i.salary
        }
        return salary
    }
    
    var waterExpenseCount:Int{
        var water = 0
        for i in animalSitters{
            water += i.waterConsumption
        }
        return water
    }
    
    func addAnimalSitter(person:AnimalSitter){
        animalSitters.append(person)
    }
    
    func addFunds(_ value:UInt){
        self.budget += Int(value)
    }
    func removeFunds(_ value:UInt){
        self.budget -= Int(value)
    }
    
    func paySalaries() {
        for i in animalSitters{
            self.budget -= i.salary
        }
    }
    
    func editWater(water:Int){
        self.water += water
    }
    
    func useWater(){
        for i in animalSitters{
            self.water -= i.waterConsumption
        }
    }
    
    init(name:String,year:Int,budget:Int,water:Int) {
        self.name = name
        self.year = year
        self.budget = budget
        self.water = water
        self.animalSitters = []
    }

}

class AnimalSitter:Labor{
    var id:Int
    var name: String
    var age: Int
    var isMarried: Bool
    var salaryFactor: Int
    var salary: Int{
        return salaryFactor + age * 75
    }
    var waterConsumption:Int{
        var water = 0
        for i in animals{
            water += i.waterConsumption
        }
        return water
    }
    
    var animals: [Animal]
    var animalCount:Int {
        return animals.count
    }
    
    init(id:Int, name:String, age:Int, isMarried:Bool, salaryFactor:Int) {
        self.id = id
        self.name = name
        self.age = age
        self.isMarried = isMarried
        self.salaryFactor = salaryFactor
        self.animals = []
    }
    
    func addAnimal(animal: Animal){
        if (animal.owner == nil){
            animals.append(animal)
            animals[animalCount-1].owner = self
        }
        else{
            print("this animal have owner")
        }
    }
        
}


protocol Animal{
    var name:String {get set}
    var waterConsumption:Int {get}
    var owner:AnimalSitter? {get set}
    var ownerID:Int? {get set}
    var type:AnimalType {get set}
}

class Cat:Animal{
    var name: String
    weak var owner: AnimalSitter?
    var ownerID: Int?
    var waterConsumption:Int
    var type: AnimalType

    
    init(name: String, owner: AnimalSitter? = nil) {
        self.name = name
        self.owner = owner
        self.ownerID = owner?.id
        self.waterConsumption = 1
        self.type = AnimalType.cat
    }
    
}

class Dog:Animal{
    var name: String
    weak var owner: AnimalSitter?
    var ownerID: Int?
    var waterConsumption:Int
    var type:AnimalType
    
    init(name: String, owner: AnimalSitter? = nil) {
        self.name = name
        self.owner = owner
        self.ownerID = owner?.id
        self.waterConsumption = 2
        self.type = AnimalType.dog
    }
}

//
//  File.swift
//  techCompanyApp
//
//  Created by Kerem Safa Dirican on 17.11.2022.
//

import Foundation

enum DevLevel {
    case jr
    case mid
    case sr
    
}

protocol Labor{
    var name:String {get set}
    var age:Int {get set}
    var isMarried:Bool {get set}
    var salaryFactor:Int {get set}
    var salary:Int {get}
}

class Developer:Labor{
    var name: String
    var age: Int
    var isMarried:Bool
    var experience: DevLevel
    var salaryFactor:Int
    var salary: Int {
        let ageBonus = age > 20 ? age - 20 : 0
        switch experience {
        case .jr:
            return (15) * salaryFactor
        case .mid:
            return (20 + ageBonus) * salaryFactor
        case .sr:
            return (30 + ageBonus) * salaryFactor
            
        }
    }
    
    init(name: String, age:Int, isMarried:Bool, experience: DevLevel, salaryFactor:Int) {
        self.name = name
        self.age = age
        self.isMarried = isMarried
        self.experience = experience
        self.salaryFactor = salaryFactor
    }
    
}


protocol Company{
    var name:String {get set}
    var year:Int {get set}
    var budget:Int {get}
    
    func addFunds(_ value:UInt)
    func removeFunds(_ value:UInt)
    func paySalaries()
}



class TechCompany: Company{
    var name: String
    var year: Int
    private(set) var budget: Int
    var developers: [Developer]
    var developerCount: Int {
        return developers.count
    }
    var salarySum:Int{
        var salary = 0
        for i in developers{
            salary += i.salary
        }
        return salary
    }
    
    required init(name: String, year: Int, budget: Int) {
        self.name = name
        self.year = year
        self.budget = budget
        self.developers = []
    }
    
    //MARK: - Personel Functions
    func hireDeveloper(dev:Developer){
        developers.append(dev)
    }
    
    // fires a random developer
    func elonMode(){
        guard developerCount > 0 else {
            return
        }
        let luckyNumber = Int.random(in: 0..<developerCount)
        developers.remove(at: luckyNumber)
    }
    
    //MARK: - Accounting Functions
    
    func addFunds(_ value:UInt){
        self.budget += Int(value)
    }
    func removeFunds(_ value:UInt){
        self.budget -= Int(value)
    }
    
    func paySalaries(){
        for i in developers{
            budget -= i.salary
        }
    }
    
}

//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String
   

  public func convert(_ to: String) -> Money {
    var newAmount : Int = 0
    switch currency {
    case "USD" :
        if to == "GBP" {
            
            newAmount = amount / 2
            print("AMOUNT \(amount) " )
            print("NEW AMOUNT \(newAmount) " )
        }
        if to == "EUR" {
            newAmount = amount * 3 / 2
        }
        if to == "CAN" {
            newAmount = amount * 5 / 4
        }
    case "GBP" :
        newAmount = amount * 2
        if to == "EUR" {
            newAmount = amount * 3 / 2
        }
        if to == "CAN" {
            newAmount = amount * 5 / 4
        }
    case "EUR" :
        newAmount = amount * 2 / 3
        if to == "GBP" {
            newAmount = amount / 2
        }
        if to == "CAN" {
            newAmount = amount * 5 / 4
        }
    case "CAN" :
        newAmount = amount / 5 * 4
        if to == "GBP" {
            newAmount = amount / 2
        }
        if to == "EUR" {
            newAmount = amount * 3 / 2
        }
    default :
        print("nothing done")
    }
    return Money(amount: newAmount, currency: to)

}


  public func add(_ to: Money) -> Money {
    if to.currency == currency {
        return Money(amount: amount + to.amount, currency: to.currency)
    }
    let finalCurrency = convert(to.currency)
    return Money(amount: finalCurrency.amount + to.amount, currency: to.currency)
  }
    
  public func subtract(_ from: Money) -> Money {
    if from.currency == currency {
        return Money(amount: amount + from.amount, currency: from.currency)
    }
    let finalCurrency = convert(from.currency)
    return Money(amount: finalCurrency.amount + from.amount, currency: from.currency)
    }
    
}
//
//let tenUSD = Money(amount: 10, currency: "USD")
//let gbp = tenUSD.convert("GBP")
//print(tenUSD)
//print(gbp.amount)
//print(gbp.currency == "GBP")
//print(gbp.amount == 5)
//
//

//////////////////////////////////
// Job

open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
  
  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
    switch type {
    case .Hourly(let value):
        return Int(Double(hours) * value);
    case .Salary(let value):
        return value;
    }
  }
  
  open func raise(_ amt : Double) {
    switch type {
    case .Hourly(let value):
        self.type = JobType.Hourly(value + amt)
    case .Salary(let value):
        self.type = JobType.Salary(value + Int(amt))
    }
  }
}
let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
print(job.calculateIncome(10) == 150)

job.raise(1.0)
print(job.calculateIncome(10))
print(job.calculateIncome(10) == 160)

//
//////////////////////////////////////
//// Person
////

open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

  fileprivate var _job : Job? = nil
  open var job : Job? {
    get {  return _job }
    set(value) {
        if age >= 16 {
            _job = value
        }
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { return _spouse }
    set(value) {
        if age >= 18 {
            _spouse = value
        }
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
    return("[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(_job) spouse:\(_spouse)]")
    }
}

//
//////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
    
    
  public init(spouse1: Person, spouse2: Person) {
    if spouse1._spouse == nil && spouse2._spouse == nil {
        spouse1._spouse = spouse2
        spouse2._spouse = spouse1
        members.append(spouse1)
        members.append(spouse2)
    }
  }
  
  open func haveChild(_ child: Person) -> Bool {
    var canHaveKids : Bool = false
    for member in members {
        if member.age >= 21 {
            canHaveKids = true
        }
    }
    if canHaveKids {
        child.age = 0
        members.append(child)
    }
    return canHaveKids
  }
//    //what is legal for 21???
//
  open func householdIncome() -> Int {
    var totalIncome : Int = 0
    for member in members {
        if(member.job != nil) {
       totalIncome += (member._job?.calculateIncome(2000))!
        }
    }
    return totalIncome
    }
}






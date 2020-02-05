//                                      
//  EmployeeListView.swift
//  AlamofireDemo
//
//  Created by Bhushan  Borse on 05/01/20.
//  Copyright © 2020 Bhushan  Borse. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

class EmployeeListView: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tableViewEmp : UITableView!

    var employeeModel               : [ModelClass] = []
        
    var people                      : [NSManagedObject] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getEmployeeDetailsFromServer()
        
        //checkUniqueCharecterFromString(string: "addffhhk")
       // printUniqueCompleteSubString(from: "addh")
        
        
        
        let kkk = "ssg"
        
        kkk.forEach { (char) in
            var charCount = 0
            kkk.forEach { (checkChar) in
                if checkChar == char {
                    charCount += 1
                    if charCount > 1 {
                        return
                    }
                }
            }
            
            if charCount == 1 {
                print("\(char) is unique charecter")
            }
        }
        
    }
    
    func checkUniqueCharecterFromString(string : String)  {
        for char in string {
            var charCount = 0
            for checkChar in string {
                if checkChar == char {
                    charCount += 1
                    if charCount > 1 {
                        break
                    }
                }
            }
            
            if charCount == 1 {
                print("\(char) Char is Unique")
            }
        }
        
    }
    
    
        
    func getEmployeeDetailsFromServer() {
        RestClient().callApi(api: "http://dummy.restapiexample.com/api/v1/employees", completion: { (error, json) in
            if error == nil {
                let empJson = json?["data"].arrayValue
                for item in empJson ?? [] {
                    self.employeeModel.append(ModelClass.init(fromJson: item))
                    self.saveEmployeeDataInCoreData(modelObject: ModelClass.init(fromJson: item))
                }
                
                print(self.people.count)
                
                self.tableViewEmp.reloadData()
            } else {
                RestClient().showAlertView(message: String(describing: error), from: self)
            }
        }, type: "GET", data: nil, isAbsoluteURL: true, headers: nil, isSilent: false)
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewEmp.dequeueReusableCell(withIdentifier: "EmployeeViewCell", for: indexPath) as! EmployeeViewCell
        cell.selectionStyle = .none
                
       /* let employeeObject = self.people[indexPath.row]//employeeModel[indexPath.row]
        
        cell.NameLabel.text = employeeObject.employeeName
        
        cell.idLabel.text = "Id : \(employeeObject.id)"
        cell.ageLable.text = "Age : \(employeeObject.employeeAge)"
        cell.salaryLable.text = "Salary : \(employeeObject.employeeSalary)"*/
        return cell
    }
    
    
    func saveEmployeeDataInCoreData(modelObject : ModelClass) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "Person",
                                   in: managedContext)!
      
      let person = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      // 3
        person.setValue(modelObject.employeeName, forKeyPath: "name")
        person.setValue(modelObject.id, forKeyPath: "id")
        person.setValue(modelObject.employeeAge, forKeyPath: "age")
        person.setValue(modelObject.employeeSalary, forKeyPath: "salary")
      
      // 4
      do {
        try managedContext.save()
        people.append(person)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
}


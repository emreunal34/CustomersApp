//
//  CustomersDao.swift
//  CustomersApp
//
//  Created by Caner Ünal on 24.02.2024.
//

import Foundation

class CustomersDao {
    
    let db:FMDatabase?
    
    init() {
        let destinationWay = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let databaseURL = URL(fileURLWithPath: destinationWay).appendingPathComponent("customers.sqlite")
        db = FMDatabase(path: databaseURL.path)
        
    }
    
    func getToAllCustomers() -> [Customers] {
        var list = [Customers]()
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM customers", values: nil)
            
            while rs.next() {
                let customer = Customers(customer_id: Int(rs.string(forColumn: "customer_id"))!,
                                         customer_name: rs.string(forColumn: "customer_name")!, customer_tel: rs.string(forColumn: "customer_number")!)
                list.append(customer)
                
            }
        } catch  {
            print(error.localizedDescription)
        }
        
        
        db?.close()
        
        return list
    }
    
    func searchPerson(customer_name:String) -> [Customers] {
        var list = [Customers]()
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM customers WHERE customer_name like '%\(customer_name)%'", values: nil)
            
            while rs.next() {
                let customer = Customers(customer_id: Int(rs.string(forColumn: "customer_id"))!,
                                         customer_name: rs.string(forColumn: "customer_name")!, customer_tel: rs.string(forColumn: "customer_number")!)
                list.append(customer)
                
            }
        } catch  {
            print(error.localizedDescription)
        }
        
        
        db?.close()
        
        return list
    }
    
    func newPerson(customer_name:String,customer_number:String) {
        
        db?.open()
        
        do {
            try db!.executeUpdate("INSERT INTO customers (customer_name,customer_number) VALUES(?,?)", values: [customer_name,customer_number])
            
            
        } catch  {
            print(error.localizedDescription)
        }
        db?.close()
        
    }
    
    func deletePerson(customer_id:Int) {
        
        db?.open()
        
        do {
            try db!.executeUpdate("DELETE FROM customers WHERE customer_id = ?", values: [customer_id])
            
            
        } catch  {
            print(error.localizedDescription)
        }
        db?.close()
        
    }
    
    func updatePerson(customer_id:Int,customer_name:String,customer_number:String) {
        
        db?.open()
        
        do {
            try db!.executeUpdate("UPDATE customers SET customer_name = ? , customer_number = ? WHERE customer_id = ?", values: [customer_id,customer_name,customer_number])
            
            
        } catch  {
            print(error.localizedDescription)
        }
        db?.close()
        
    }
    
            
    
}

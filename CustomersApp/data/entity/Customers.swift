//
//  Customers.swift
//  CustomersApp
//
//  Created by Caner Ünal on 24.02.2024.
//

import Foundation

class Customers {
    
    var customer_id:Int?
    var customer_name:String?
    var customer_tel:String?
    
    init() {
    }
    
    init(customer_id: Int, customer_name: String, customer_tel: String) {
        self.customer_id = customer_id
        self.customer_name = customer_name
        self.customer_tel = customer_tel
    }
    
}



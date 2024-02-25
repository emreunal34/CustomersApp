//
//  DetailPage.swift
//  CustomersApp
//
//  Created by Caner Ünal on 24.02.2024.
//

import UIKit

class UpdateCustomerPage: UIViewController {

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldNumber: UITextField!
    
    var customer:Customers?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let c = customer {
            textFieldName.text = c.customer_name
            textFieldNumber.text = c.customer_tel
        }

        
    }
    
    @IBAction func buttonUpdate(_ sender: Any) {
        if let k = customer , let name = textFieldName.text, let number = textFieldNumber.text  {
            CustomersDao().updatePerson(customer_id:k.customer_id!,customer_name: name, customer_number: number)
            
        }
    }
    
    
}

//
//  NewCustomerPage.swift
//  CustomersApp
//
//  Created by Caner Ünal on 24.02.2024.
//

import UIKit

class NewCustomerPage: UIViewController {

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func buttonSave(_ sender: Any) {
        if let name = textFieldName.text, let number = textFieldNumber.text {
            CustomersDao().newPerson(customer_name: name, customer_number: number)
            
        }
    }
    

}

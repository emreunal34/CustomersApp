//
//  ViewController.swift
//  CustomersApp
//
//  Created by Caner Ünal on 24.02.2024.
//

import UIKit

class HomePage: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var customersTableView: UITableView!
    var customersList = [Customers]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        customersTableView.dataSource = self
        customersTableView.delegate = self
        
        databaseCopy()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customersList = CustomersDao().getToAllCustomers()
        customersTableView.reloadData()
    }
    
    func databaseCopy(){
            let bundleWay = Bundle.main.path(forResource: "customers", ofType: ".sqlite")
            let destinationWay = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let placeToCopy = URL(fileURLWithPath: destinationWay).appendingPathComponent("customers.sqlite")
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: placeToCopy.path){
                print("Veritabanı zaten var")
            }else{
                do{
                    try fileManager.copyItem(atPath: bundleWay!, toPath: placeToCopy.path)
                }catch{}
            }
    }

}

extension HomePage : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Kişi ad: \(searchText)")
        
        customersList = CustomersDao().searchPerson(customer_name: searchText)
        customersTableView.reloadData()
    }
    
}
extension HomePage : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customersList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customer = customersList[indexPath.row]
        let cell = customersTableView.dequeueReusableCell(withIdentifier: "customerCell") as! CustomersCell
        
        cell.labelName.text = customer.customer_name
        cell.labelNumber.text = customer.customer_tel
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let customer = customersList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: customer)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let customer = sender as? Customers {
                let goToUpdatePage = segue.destination as! UpdateCustomerPage
                goToUpdatePage.customer = customer
            }
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let updateAction = UIContextualAction(style: .normal, title: "Güncelle") {  contextualAction,view,bool in
            
            self.performSegue(withIdentifier: "toDetail", sender: indexPath.row)
        }
        
        let cancelAction = UIContextualAction(style: .destructive, title: "Sil") { contextualAction,view,bool in
            let customer = self.customersList[indexPath.row]
            
            let alertController = UIAlertController(title: "Silme İşlemi", message: "\(customer.customer_name!) adlı kişiyi silmek istediğinize emin misiniz?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Sil", style: .destructive) { action in
                
                CustomersDao().deletePerson(customer_id: customer.customer_id!)
                
                self.customersList = CustomersDao().getToAllCustomers()
                self.customersTableView.reloadData()
                
            }
            alertController.addAction(deleteAction)
            
            let cancelAction = UIAlertAction(title: "İptal", style: .cancel)
            alertController.addAction(cancelAction)
            
            
            self.present(alertController,animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [cancelAction,updateAction])
    }
    
}


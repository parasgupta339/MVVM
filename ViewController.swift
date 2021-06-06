//
//  ViewController.swift
//  MVVM
//
//  Created by paras gupta on 05/06/21.
//

import UIKit

class ViewController: UIViewController{
    
    let parser = Parser()
    
    var contacts = [Contact]()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        parser.Parse{
            data in
            self.contacts = data
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
        
        
    }
   
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row].name
        return cell
    }
    
    
}
extension ViewController: UITableViewDelegate{
    
}

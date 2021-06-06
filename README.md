# MVVM

#Model: User.swift

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let contacts: [Contact]
}

// MARK: - Contact
struct Contact: Codable {
    let id, name, email: String
    
}


#viewModel:  Parser.swift

import Foundation

struct Parser{
    func Parse(comp: @escaping ([Contact])->()){
        let api = URL(string: "https://api.androidhive.info/contacts/")
        URLSession.shared.dataTask(with: api!){
            data, response, error in
            if error != nil{
                print(error?.localizedDescription)
                return
            }
            do{
            let result = try JSONDecoder().decode(Welcome.self, from: data!)
                comp(result.contacts)
            }catch{
                
            }
        }.resume()
    }
}

#controller: ViewController

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

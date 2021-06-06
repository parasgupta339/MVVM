//
//  Parser.swift
//  MVVM
//
//  Created by paras gupta on 05/06/21.
//

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

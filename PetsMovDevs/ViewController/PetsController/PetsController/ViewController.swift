//
//  ViewController.swift
//  PetsMovDevs
//
//  Created by Jose David Bustos H on 25-04-20.
//  Copyright © 2020 Jose David Bustos H. All rights reserved.
//

import UIKit
import Foundation
class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    var  viewModelPets = ViewModelControlPets()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelPets.downloadJsonPets()
        SetUpData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

    func SetUpData()  {
        viewModelPets.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModelPets.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
            }
        }
    }
}

extension ViewController{
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return viewModelPets.arrayOfList.count
           }
           
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell else { return UITableViewCell() }
               let listObj = viewModelPets.arrayOfList[indexPath.row]
               
              cell.LabelNamePet.text = listObj.uppercased()

               return cell
           }
           func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             print("deberia abrir Details")
                     
             performSegue(withIdentifier: "showDetails", sender: self)
           }
          override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              let listObj = viewModelPets.arrayOfList[(tableView.indexPathForSelectedRow?.row)!]
              if let destination = segue.destination as? PetsDetailVC{
                  destination.nameString = listObj

              }
         }
}


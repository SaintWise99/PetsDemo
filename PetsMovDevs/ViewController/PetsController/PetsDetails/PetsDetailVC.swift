//
//  PetsDetailVC.swift
//  PetsMovDevs
//
//  Created by Jose David Bustos H on 26-04-20.
//  Copyright © 2020 Jose David Bustos H. All rights reserved.
//

import UIKit
import Foundation
class PetsDetailVC: UIViewController
{
    private let apiManagerPicture = PetViewModelPicture()
    var  viewModelPets = ViewModelControlPets()
    var nameString:String!
    @IBOutlet weak var LabelNamePets: UILabel!
    @IBOutlet weak var imagenMascota: UIImageView!
    @IBOutlet weak var buttonNextPhoto: UIButton!
    @IBOutlet weak var IndicatorActivityLoad: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPhotoMascota()
        setObjectViewController()
    }
    @IBAction func buttonNextPhoto(_ sender: Any){
        loadPhotoMascota()
    }
}

extension PetsDetailVC{
    
    func setObjectViewController()
    {
       self.LabelNamePets.text = nameString.uppercased()
       buttonNextPhoto.layer.cornerRadius = 15
    }
    func  IndicatorActivityLoadInit(){
          self.buttonNextPhoto.isEnabled=false
          self.IndicatorActivityLoad.isHidden = false
          self.IndicatorActivityLoad.style = .large
          self.IndicatorActivityLoad.color = .white
          self.IndicatorActivityLoad.startAnimating()
      }
      func  IndicatorActivityLoadStop(){
          
          self.IndicatorActivityLoad.isHidden = true
          self.IndicatorActivityLoad.stopAnimating()
          self.buttonNextPhoto.isEnabled=true
      }
    func loadPhotoMascota()
    {
        if (nameString != "")
        {
            IndicatorActivityLoadInit()
            self.apiManagerPicture.getPetPhotoContext(namePet: nameString) { (contexts, error) in
                if let error = error {
                    print("Get contexts error: \(error.localizedDescription)")
                    self.printError(errorStr:error.localizedDescription)
                    return
                }
                guard let contexts = contexts  else { return }
                print("Current contexts Object:")
                DispatchQueue.main.sync {
                    if let paths:String = contexts.message{
                         if let imageURL = URL(string:paths) {
                             print(imageURL)
                                 let data = try? Data(contentsOf: imageURL)
                                 if let data = data {
                                     let image = UIImage(data: data)
                                     DispatchQueue.main.async {
                                        self.IndicatorActivityLoadStop()
                                        self.buttonNextPhoto.isEnabled=true
                                        self.imagenMascota.image = image
                                     }
                                 }
                         }
                }
            }
         }
        }else{
            self.printError(errorStr:"Ocurrio un error , reintente nuevamente")
        }
    }
    
    func printError(errorStr:String)
       {
           let alert = UIAlertController(title: "Ocurrio un error", message: errorStr, preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }
}

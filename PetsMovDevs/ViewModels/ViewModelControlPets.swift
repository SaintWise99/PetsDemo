//
//  ViewModelControlPets.swift
//  PetsMovDevs
//
//  Created by Jose David Bustos H on 25-04-20.
//  Copyright © 2020 Jose David Bustos H. All rights reserved.
//

import Foundation

class ViewModelControlPets {

    var endPViewModel = EndPointViewModel()
    var reloadList = {() -> () in }
    var errorMessage = {(message : String) -> () in }
    var arrayOfListPictures : [String] = []
    var arrayOfList : [String] = []{
     
        didSet{
            reloadList()
        }
    }

    func downloadJsonPets(){
        
        let endpointData = endPViewModel.getEndpoint(fromName: "EndPointPets")!
        let urlhttp = endpointData.url.absoluteString
        print(urlhttp)
        
        //guard let downloadURL = url else { return }
        guard let downloadURL = URL(string:urlhttp) else { return }
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("algo fallo")
                return
            }
            print("descargado")
            do
            {
                let decoder = JSONDecoder()
                let downloadedData = try decoder.decode(Pets.self ,from: data)
 
                self.arrayOfList = downloadedData.message
               
                  print(self.arrayOfList)
                
            } catch {
                print("ocurrio un error despues de descarga")
            }
            }.resume()
    }

}

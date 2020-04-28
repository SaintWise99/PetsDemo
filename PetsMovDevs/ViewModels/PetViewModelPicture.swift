//
//  PetViewModelPicture.swift
//  PetsMovDevs
//
//  Created by Jose David Bustos H on 25-04-20.
//  Copyright © 2020 Jose David Bustos H. All rights reserved.
//

import Foundation

class PetViewModelPicture {
    var endPViewModel = EndPointViewModel()
    func getPetPhotoContext(namePet:String , completion: @escaping (_ contexts: PetPhoto?, _ error: Error?) -> Void) {
        let endpointData = endPViewModel.getEndpoint(fromName: "EndPointPets")!
        let urlhttp = endpointData.urlBase.absoluteString
        let urlhttpImage = endpointData.urlImage.absoluteString
        print(urlhttp)
            getJSONFromURL(urlString: urlhttp + namePet + urlhttpImage) { (data, error) in
                guard let data = data, error == nil else {
                    print("Failed to get data")
                    return completion(nil, error)
                }
                self.createContextObjectWith(json: data, completion: { (contexts, error) in
                    if let error = error {
                        print("Failed to convert data")
                        
                        return completion(nil, error)
                    }
                    return completion(contexts, nil)
                })
            }
        
    }
}

extension PetViewModelPicture {
    private func getJSONFromURL(urlString: String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Error: Cannot create URL from string")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            guard error == nil else {
                print("Error calling api")
                return completion(nil, error)
            }
            guard let responseData = data else {
                print("Data is nil")
                return completion(nil, error)
            }
            completion(responseData, nil)
        }
        task.resume()
    }
    
    private func createContextObjectWith(json: Data, completion: @escaping (_ data: PetPhoto?, _ error: Error?) -> Void) {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let contexts = try decoder.decode(PetPhoto.self, from: json)
            return completion(contexts, nil)
        } catch let error {
            print("Error creating current contexts from JSON because: \(error.localizedDescription)")
            return completion(nil, error)
        }
    }
    
}

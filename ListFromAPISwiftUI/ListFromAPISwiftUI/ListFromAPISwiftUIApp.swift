//
//  ListFromAPISwiftUIApp.swift
//  ListFromAPISwiftUI
//
//  Created by Lyvennitha on 22/03/21.
//

import SwiftUI

@main
struct ListFromAPISwiftUIApp: App {
    var countries = [Country]()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


struct Country: Codable, Hashable{
    var name: String?
    var population: Int?
}

class Network{
    func getCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        
        guard let url = URL(string: "https://restcountries.eu/rest/v2/all") else {
            print("invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url){(data, response, error) in
            if let error = error{
                completion(.failure(error.localizedDescription as! Error))
                return
            }
            
            do{
                let countries = try! JSONDecoder().decode([Country].self, from: data!)
                completion(.success(countries))
                print(countries)
            }catch let jsonError{
                completion(.failure(jsonError.localizedDescription as! Error))
            }
        }.resume()
        
    }
}
extension ListFromAPISwiftUIApp{
    mutating func getCuntries(){
        var selfi = self
        Network().getCountries { (result) in
            switch result{
            case .success(let countries):
                DispatchQueue.main.async {
                    selfi.countries = countries
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

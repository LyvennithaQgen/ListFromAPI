//
//  ContentView.swift
//  ListFromAPISwiftUI
//
//  Created by Lyvennitha on 22/03/21.
//

import SwiftUI

struct ContentView: View {
    init() {
          UITableView.appearance().backgroundColor = .clear
          UITableViewCell.appearance().backgroundColor = .clear
        UIStackView.appearance().backgroundColor = .clear
      }
    @State var countries = [Country]()
    var body: some View {
        NavigationView{
            List(countries, id:\.self){
                country in
                HStack(spacing: 10){
                    Text(country.name ?? "")
                        .bold()
                        .minimumScaleFactor(0.5)
                    
                    Spacer()
                    BasicImageRow()
                        .contextMenu(ContextMenu(menuItems: {
                            Text("Share")
                            Text("Delete")
                            Text("Info")
                        }))
                    Text("\(country.population ?? 0)")
                        .bold()
                        .minimumScaleFactor(0.5)
                }
            }//.background(Image("BG").blur(radius: 3))
            .onAppear(){
                getCuntries()
            }
            .navigationTitle("Country")
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView{
    func getCuntries(){
        let selfi = self
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

struct BasicImageRow: View {
    
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
        }
    }
}

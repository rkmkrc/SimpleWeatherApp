//
//  SearchScreen.swift
//  SimpleWeatherApp
//
//  Created by Erkam Karaca on 28.05.2023.
//

import Foundation
import UIKit

class SearchScreen: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var citiesTableView: UITableView!
    var cities: [JsonCity] = [] {
        didSet {
            citiesTableView.reloadData()
        }
    }
    var filteredCities: [JsonCity] = [] {
        didSet {
            citiesTableView.reloadData()
        }
    }
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cities"
        citiesTableView.dataSource = self
        citiesTableView.delegate = self
        setupSearchBar()
        loadCitiesFromJSON()
    }
    
    private func setupSearchBar() {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Cities"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    func loadCitiesFromJSON() {
        guard let fileURL = Bundle.main.url(forResource: "city.list", withExtension: "json") else {
            print(MyError.JSON_FILE_NOT_FOUND_ERROR)
            return
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let cities = try decoder.decode([JsonCity].self, from: data)
            self.cities = cities
            self.filteredCities = cities
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        let city = filteredCities[indexPath.row]
        cell.textLabel?.text = city.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let city = filteredCities[indexPath.row]
        performSegue(withIdentifier: "goToDetails", sender: city.id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails",
           let detailsScreen = segue.destination as? HomeScreen,
           let cityID = sender as? Int {
            detailsScreen.cityID = String(cityID)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredCities = cities
        } else {
            filteredCities = cities.filter { $0.name?.localizedCaseInsensitiveContains(searchText) ?? false }
        }
        citiesTableView.reloadData()
    }
}



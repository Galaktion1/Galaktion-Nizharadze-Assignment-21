//
//  ViewController.swift
//  Galaktion Nizharadze, Assignment #21
//
//  Created by Gaga Nizharadze on 11.08.22.
//

import UIKit

class ViewController: UIViewController {
    
    var countryList: [Country] = [Country]()
    
    var filteredData = [Country] ()
    
    private struct UIConstants {
        static let searchBarAndTableViewX: CGFloat = 0
        static let searchBarY: CGFloat = 180
        static let searchBarAndTableViewWidth: CGFloat = UIScreen.main.bounds.width
        static let searchBarHeight: CGFloat = 50
         
        static let tableViewY: CGFloat = 230
        static let tableViewHeight: CGFloat = UIScreen.main.bounds.height - 180
    }
    
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search here..."
        bar.frame = CGRect(x: UIConstants.searchBarAndTableViewX,
                           y: UIConstants.searchBarY,
                           width: UIConstants.searchBarAndTableViewWidth,
                           height: UIConstants.searchBarHeight)
        return bar
    }()
    
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.frame = CGRect(x: UIConstants.searchBarAndTableViewX,
                                 y: UIConstants.tableViewY,
                                 width: UIConstants.searchBarAndTableViewWidth,
                                 height: UIConstants.tableViewHeight)
        
        return tableView
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Countries"
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(tableView)
        fetchCountry()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
 
    
    private func fetchCountry() {
        FetchCountries.shared.fetchCountry { result in
            switch result {
            case .success(let countries):
                self.countryList = countries
                self.filteredData = self.countryList
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
      
        }
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = filteredData[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CountryDetailsViewController()
        
        vc.data = filteredData[indexPath.row]
//        let url = URL(string: filteredData[indexPath.row].flagURL)!
//        vc.mainImageView.load(url: url)
//        print(url)
//        print(Thread.current)
//        
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredData = searchText.isEmpty ? countryList : countryList.filter({(dataString: Country) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.name.range(of: searchText, options: .caseInsensitive) != nil
        })

        tableView.reloadData()
    }
}

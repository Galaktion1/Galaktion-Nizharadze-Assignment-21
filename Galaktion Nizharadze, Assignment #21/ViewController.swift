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
    
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.medium)
    
    
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
        confNavigationControllerAndViewSubviews()
        fetchCountry()
        tableViewAndSearchbarDelegateConform()
    }
    
    
    private func confNavigationControllerAndViewSubviews() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Countries"
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.view.center
    }
    
    private func tableViewAndSearchbarDelegateConform() {
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
                self.activityIndicator.removeFromSuperview()
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

        navigationController?.pushViewController(vc, animated: true)
    }
}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = searchText.isEmpty ? countryList : countryList.filter({(dataString: Country) -> Bool in
            return dataString.name.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        tableView.reloadData()
    }
}
